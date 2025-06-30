// lib/cubits/GetPosts_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/features/posts/data/repos/posts_repo.dart';
import 'package:zoom_clone/features/posts/presentation/controller/cubit/get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  final PostsRepository repository;

  GetPostsCubit(this.repository) : super(GetPostsInitial());

  Future<void> getGetPosts() async {
    emit(GetPostsLoading());
    try {
      final posts = await repository.fetchPosts();
      emit(GetPostsLoaded(posts));
    } catch (e, stackTrace) {
      String errorMessage = "Unexpected error occurred";

      if (e is DioException) {
        errorMessage = e.message ?? "Dio error occurred";
      }

      print("❌ GetPostsCubit Error: $e");
      print("📛 StackTrace: $stackTrace");

      emit(GetPostsError(errorMessage));
    }
  }
}
