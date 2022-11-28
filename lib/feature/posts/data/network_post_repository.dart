import 'package:flutter_client_it_product/app/domain/app_api.dart';
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
}
