import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final Dio client;

  PostRemoteDataSource(this.client);

  Future<List<PostModel>> fetchPosts() async {
    final response = await client.get("https://jsonplaceholder.typicode.com/posts");
    return (response.data as List).map((json) => PostModel.fromJson(json)).toList();
  }
}
