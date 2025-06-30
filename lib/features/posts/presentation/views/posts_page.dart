// lib/features/posts/presentation/views/posts_page.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/features/posts/presentation/controller/cubit/get_posts_state.dart';
import '../controller/cubit/get_posts_cubit.dart';

class GetPostsPage extends StatefulWidget {
  const GetPostsPage({super.key});

  @override
  State<GetPostsPage> createState() => _GetPostsPageState();
}

class _GetPostsPageState extends State<GetPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocBuilder<GetPostsCubit, GetPostsState>(
        builder: (context, state) {
          if (state is GetPostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title ?? ""),
                  subtitle: Text(post.body ?? ""),
                );
              },
            );
          } else if (state is GetPostsError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("Press button to load posts"));
        },
      ),
    );
  }
}
