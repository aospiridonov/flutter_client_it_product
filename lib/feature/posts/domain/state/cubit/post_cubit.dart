import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';
import 'package:flutter_client_it_product/feature/posts/domain/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';
part 'post_cubit.g.dart';

class PostCubit extends HydratedCubit<PostState> {
  PostCubit(this.postRepository, this.authCubit)
      : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSubscription = authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (value) => fetchPosts(),
        notAuthorized: (value) => logOut(),
      );
    });
  }

  final PostRepository postRepository;
  final AuthCubit authCubit;
  late final StreamSubscription authSubscription;

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

  void logOut() => emit(state.copyWith(
        asyncSnapshot: const AsyncSnapshot.nothing(),
        postList: [],
      ));

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    return PostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
