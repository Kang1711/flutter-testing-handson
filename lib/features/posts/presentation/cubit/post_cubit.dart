import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../../data/post_repository.dart';

sealed class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostSuccess extends PostState {
  final List<Post> posts;
  const PostSuccess(this.posts);
}

class PostFailure extends PostState {
  final String message;
  const PostFailure(this.message);
}

class PostCubit extends Cubit<PostState> {
  final IPostRepository repo;
  PostCubit(this.repo) : super(const PostInitial());
  Future<void> fetch() async {
    emit(const PostLoading());
    try {
      final data = await repo.getPosts();
      emit(PostSuccess(data));
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }
}
