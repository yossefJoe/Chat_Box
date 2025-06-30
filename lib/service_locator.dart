// lib/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/posts/data/posts_api_service.dart';
import 'features/posts/data/repos/posts_repo.dart';
import 'features/posts/presentation/controller/cubit/get_posts_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Configure Dio properly
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      headers: {
        "Accept": "application/json",
      },
    ));

    // Add logger to print requests/responses
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  });

  // Retrofit API Service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // Repository
  getIt.registerLazySingleton<PostsRepository>(
      () => PostsRepository(getIt<ApiService>()));

  // Cubit
  getIt.registerFactory<GetPostsCubit>(
      () => GetPostsCubit(getIt<PostsRepository>()));
}
