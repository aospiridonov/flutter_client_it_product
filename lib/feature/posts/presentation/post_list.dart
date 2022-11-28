import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/presentation/app_loader.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:flutter_client_it_product/feature/posts/presentation/post_item.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.postList.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.postList.length,
            itemBuilder: (context, index) =>
                PostItem(postEntity: state.postList[index]),
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
