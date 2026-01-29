import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/posts/data/post_repository.dart';
import 'features/posts/presentation/cubit/post_cubit.dart';
import 'features/posts/presentation/pages/post_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = DioClient.build(); // baseUrl jsonplaceholder
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostCubit(PostRepository(dio))),
      ],
      child: MaterialApp(
        title: 'Flutter Testing Starter',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        home: const PostPage(),
      ),
    );
  }
}