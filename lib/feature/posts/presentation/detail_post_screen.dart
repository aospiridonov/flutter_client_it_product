import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/di/init_di.dart';
import 'package:flutter_client_it_product/app/domain/error_entity/error_entity.dart';
import 'package:flutter_client_it_product/app/presentation/app_loader.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_snack_bar.dart';
import 'package:flutter_client_it_product/feature/posts/domain/entities/post/post_entity.dart';
import 'package:flutter_client_it_product/feature/posts/domain/post_repository.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/detail_post/detail_post_cubit.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailPostCubit(locator.get<PostRepository>(), id)..fetchPost(),
      child: const _DetailPostView(),
    );
  }
}

class _DetailPostView extends StatelessWidget {
  const _DetailPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<DetailPostCubit>().deletePost().then((_) {
                context.read<PostCubit>().fetchPosts();
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: BlocConsumer<DetailPostCubit, DetailPostState>(
          builder: (context, state) {
        if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }

        if (state.postEntity != null) {
          return _DetailPostItem(postEntity: state.postEntity!);
        }

        return const Center(
          child: Text('Data error'),
        );
      }, listener: (context, state) {
        if (state.asyncSnapshot.hasData) {
          AppSnackBar.showSnackBarWithMessage(
              context, state.asyncSnapshot.data.toString());
        }

        if (state.asyncSnapshot.hasError) {
          AppSnackBar.showSnackBarWithError(
              context, ErrorEntity.fromException(state.asyncSnapshot.error));
          Navigator.of(context).pop();
        }
      }),
    );
  }
}

class _DetailPostItem extends StatelessWidget {
  const _DetailPostItem({Key? key, required this.postEntity}) : super(key: key);

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Name: ${postEntity.name}'),
        Text('Content: ${postEntity.content}'),
      ],
    );
  }
}
