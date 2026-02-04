import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:flutter_testing_starter/features/posts/presentation/pages/post_page.dart';
import 'package:flutter_testing_starter/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter_testing_starter/features/posts/data/post_repository.dart';

void main() {
  testWidgets('tap Load posts -> hiển thị danh sách', (tester) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      '/posts',
      (server) => server.reply(200, [
        {'id': 1, 'title': 'Hello', 'body': 'World'},
        {'id': 2, 'title': 'Foo', 'body': 'Bar'},
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => PostCubit(PostRepository(dio)),
          child: const PostPage(),
        ),
      ),
    );

    expect(find.text('Load posts'), findsOneWidget);
    await tester.tap(find.text('Load posts'));
    await tester.pump(); // bắt đầu loading

    await tester.pump(
      const Duration(milliseconds: 50),
    ); //có thời gian chuyển sang trạng thái Loading
    //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Foo'), findsOneWidget);
  });

  // testWidgets('Hiển thị lỗi khi gọi API thất bại', (tester) async {
  //   final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
  //   final adapter = DioAdapter(dio: dio);
  //   adapter.onGet('/posts', (server) => server.reply(500, {}));
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider(
  //         create: (_) => PostCubit(PostRepository(dio)),
  //         child: const PostPage(),
  //       ),
  //     ),
  //   );
  //   await tester.tap(find.text('Load posts'));
  //   await tester.pumpAndSettle();
  //   expect(find.textContaining('Error'), findsOneWidget);
  //   expect(find.text('Retry'), findsOneWidget);
  // });

  // testWidgets('Cuộn và tìm thấy bài viết ở cuối danh sách 100 bài', (
  //   tester,
  // ) async {
  //   final manyPosts = List.generate(
  //     100,
  //     (i) => {'id': i, 'title': 'Post $i', 'body': 'Body $i'},
  //   );
  //   final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
  //   final adapter = DioAdapter(dio: dio);
  //   adapter.onGet('/posts', (server) => server.reply(200, manyPosts));

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider(
  //         create: (_) => PostCubit(PostRepository(dio)),
  //         child: const PostPage(),
  //       ),
  //     ),
  //   );

  //   expect(find.text('Load posts'), findsOneWidget);
  //   await tester.tap(find.text('Load posts'));
  //   await tester.pump(); // bắt đầu loading

  //   await tester.pump(const Duration(milliseconds: 50));
  //   await tester.pumpAndSettle();

  //   final itemFinder = find.text('Post 99');
  //   final listFinder = find.byType(ListView);
  //   await tester.scrollUntilVisible(
  //     itemFinder,
  //     500.0, // Khoảng cách mỗi lần cuộn (pixels)
  //     scrollable: find.descendant( //Tìm scrollable nằm trong listFinder
  //       of: listFinder,
  //       matching: find.byType(Scrollable),
  //     ),
  //   );
  //   expect(itemFinder, findsOneWidget);
  // });
}
