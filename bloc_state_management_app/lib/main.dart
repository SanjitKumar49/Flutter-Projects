import 'package:bloc_state_management_app/feature/posts/data/datasources/post_remote_data_source.dart';
import 'package:bloc_state_management_app/feature/posts/data/repositories/post_repository_impl.dart';
import 'package:bloc_state_management_app/feature/posts/domain/usecases/get_posts.dart';
import 'package:bloc_state_management_app/feature/posts/presentation/bloc/post_bloc.dart';
import 'package:bloc_state_management_app/feature/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Setup dependencies here
    final dio = Dio();
    final postRemoteDataSource = PostRemoteDataSource(dio);
    final postRepository = PostRepositoryImpl(postRemoteDataSource);
    final getPosts = GetPosts(postRepository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Provide the bloc to PostsPage
      home: BlocProvider(
        create: (_) => PostBloc(getPosts),
        child: PostsPage(),
      ),
    );
  }
}
