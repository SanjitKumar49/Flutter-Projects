import '../models/post_model.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getPosts() async {
    final postModels = await remoteDataSource.fetchPosts();
    return postModels.map((m) => Post(id: m.id, title: m.title, body: m.body)).toList();
  }
}
