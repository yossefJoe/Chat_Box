// lib/repositories/Posts_repository.dart

import 'package:zoom_clone/features/posts/data/models/posts_model.dart';
import 'package:zoom_clone/features/posts/data/posts_api_service.dart';



class PostsRepository {
  final ApiService apiService;

  PostsRepository(this.apiService);

  /// Fetch a Posts by ID from the API
  Future<List<PostsModel>> fetchPosts() async {
    return await apiService.getPosts();
  }
}
