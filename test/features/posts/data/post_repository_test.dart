import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_testing_starter/features/posts/data/post_repository.dart';

void main() {
  group('PostRepository', () {
    late Dio dio;
    late DioAdapter adapter;
    late PostRepository repo;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
      adapter = DioAdapter(dio: dio);
      repo = PostRepository(dio);
    });

    test('getPosts returns list of posts', () async {
      adapter.onGet('/posts', (server) {
        //Trả về data giả nếu gọi get tới /posts
        server.reply(200, [
          {'id': 1, 'title': 'T1', 'body': 'B1'},
          {'id': 2, 'title': 'T2', 'body': 'B2'},
        ]);
      });

      final result = await repo.getPosts();
      expect(result.length, 2);
      expect(result.first.title, 'T1');
    });

    test('getPosts throws on non-200', () async {
      adapter.onGet(
        '/posts',
        (server) => server.reply(500, {}),
      ); //ép Server lỗi 500 (Server sập) ngay lập tức
      expect(repo.getPosts(), throwsA(isA<DioException>()));
      // expect(
      //   repo.getPosts(),
      //   throwsA( //Xác nhận hành động văng lỗi. (only test)
      //     isA<DioException>().having( //Đầu tiên phải là loại lỗi DioEx
      //       (e) => e.response?.statusCode, // Truy cập vào statusCode
      //       'statusCode', // Tên mô tả
      //       500, // Giá trị mong đợi
      //     ),
      //   ),
      // );
    });
  });
}
