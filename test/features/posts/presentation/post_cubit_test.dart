import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_testing_starter/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter_testing_starter/features/posts/data/post_repository.dart';

void main() {
  group('PostCubit', () {
    late Dio dio;
    late DioAdapter adapter;
    late PostRepository repo;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
      adapter = DioAdapter(dio: dio);
      repo = PostRepository(dio);
    });

    blocTest<PostCubit, PostState>(
      'emits [Loading, Success] when fetch ok',
      build: () {
        adapter.onGet('/posts', (server) => server.reply(200, [
          {'id': 1, 'title': 'A', 'body': 'a'},
        ]));
        return PostCubit(repo); //Tạo ra 1 instance và đưa vào test
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [isA<PostLoading>(), isA<PostSuccess>()],
      //isA<PostSuccess>().having((s) => s.posts.first.title, 'tiêu đề bài đầu', 'A'), //s là 1 object của PostSuccess
      //isA<PostSuccess>().having((s) => s.posts, 'danh sách rỗng', isEmpty),
    );

    blocTest<PostCubit, PostState>(
      'emits [Loading, Failure] when fetch fails',
      build: () {
        adapter.onGet('/posts', (server) => server.reply(500, {}));
        return PostCubit(repo);
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [isA<PostLoading>(), isA<PostFailure>()],
    //   isA<PostFailure>().having((s) => s.message,'nội dung lỗi', contains('500')), //tin nhắn có chứa chữ '500' không,
    );
  });
}