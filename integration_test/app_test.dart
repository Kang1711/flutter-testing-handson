import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_starter/app.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App boots & has Posts title', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.text('Posts'), findsOneWidget);
  });
}

// final loadButton = find.text('Load posts');
    // expect(loadButton, findsOneWidget);

    // final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
    // final adapter = DioAdapter(dio: dio);
    // adapter.onGet(
    //   '/posts',
    //   (server) => server.reply(200, [
    //     {'id': 1, 'title': 'Hello', 'body': 'World'},
    //     {'id': 2, 'title': 'Foo', 'body': 'Bar'},
    //   ]),
    // );
    // await tester.tap(loadButton);
    // await tester.pump();
    // await tester.pump(const Duration(milliseconds: 50));
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // await tester.pumpAndSettle();
    // expect(find.byType(ListTile), findsWidgets);