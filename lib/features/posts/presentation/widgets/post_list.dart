import 'package:flutter/material.dart';
import 'package:flutter_testing_starter/features/posts/data/models/post_model.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (_, i) {
        final p = posts[i];
        return ListTile(
          title: Text(
            p.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            p.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}