import 'package:flutter/widgets.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';
import 'package:flutter_client_it_product/feature/posts/domain/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';
part 'post_cubit.g.dart';

class PostCubit extends HydratedCubit<PostState> {
  PostCubit(this.postRepository)
      : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing()));

  final PostRepository postRepository;

  Future<void> fetchPosts() async {
    await postRepository.fetchPosts().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          postList: iterable.map((e) => PostEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    super.addError(error, stackTrace);
  }

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    return PostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    return state.toJson();
  }
}
