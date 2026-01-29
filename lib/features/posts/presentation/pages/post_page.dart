import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/post_cubit.dart';
import '../widgets/post_list.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          switch (state) {
            case PostInitial():
              return Center(
                child: ElevatedButton(
                  onPressed: () => context.read<PostCubit>().fetch(),
                  child: const Text('Load posts'),
                ),
              );
            case PostLoading():
              return const Center(child: CircularProgressIndicator());
            case PostSuccess(:final posts):
              return RefreshIndicator(
                onRefresh: () => context.read<PostCubit>().fetch(),
                child: PostList(posts: posts),
              );
            case PostFailure(:final message):
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: $message'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.read<PostCubit>().fetch(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
