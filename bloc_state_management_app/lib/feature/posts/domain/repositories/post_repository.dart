import 'package:bloc_state_management_app/feature/posts/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}
