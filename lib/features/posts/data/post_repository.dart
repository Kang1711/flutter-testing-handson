import 'package:dio/dio.dart';
import 'models/post_model.dart';

 abstract class IPostRepository {
  Future<List<Post>> getPosts();
 }

class PostRepository implements IPostRepository {
  final Dio dio;
  PostRepository(this.dio);

  @override
  Future<List<Post>> getPosts() async {
    final res = await dio.get('/posts');
    final data = (res.data as List).cast<Map<String, dynamic>>();
    return data.map(Post.fromJson).toList();
  }
}