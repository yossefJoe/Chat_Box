// lib/cubits/GetPosts_state.dart
import 'package:zoom_clone/features/posts/data/models/posts_model.dart';

abstract class GetPostsState {}

class GetPostsInitial extends GetPostsState {}

class GetPostsLoading extends GetPostsState {}

class GetPostsLoaded extends GetPostsState {
  final List<PostsModel> posts;
  GetPostsLoaded(this.posts);
}

class GetPostsError extends GetPostsState {
  final String message;
  GetPostsError(this.message);
}
