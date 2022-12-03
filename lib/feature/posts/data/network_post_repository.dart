import 'package:flutter_client_it_product/app/domain/app_api.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';
import 'package:flutter_client_it_product/feature/posts/domain/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepository)
class NetworPostRepository implements PostRepository {
  final AppApi api;

  NetworPostRepository(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final response = await api.fetchPosts();
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> fetchPost(String id) async {
    try {
      final response = await api.fetchPost(id);
      return PostEntity.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> createPost(Map args) async {
    try {
      final response = await api.createPost(args);
      return response.data['message'];
    } catch (_) {
      rethrow;
    }
  }
}
