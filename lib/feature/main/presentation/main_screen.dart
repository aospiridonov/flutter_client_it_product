import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_dialog.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter_client_it_product/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter_client_it_product/feature/auth/presentation/user_screen.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:flutter_client_it_product/feature/posts/presentation/post_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.userEntity}) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MainScreen'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AppDialog(
                          val1: 'name',
                          val2: 'content',
                          onPressed: ((v1, v2) {
                            context.read<PostCubit>().createPost({
                              'name': v1,
                              'content': v2,
                            });
                          }),
                        ));
              },
              icon: const Icon(Icons.email),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserScreen(),
                ),
              ),
              icon: const Icon(Icons.account_box),
            ),
          ],
        ),
        body: const PostList(),
        floatingActionButton: FloatingActionButton(
          //onPressed: () => context.read<AuthCubit>().getProfile(),
          onPressed: () => context.read<PostCubit>().fetchPosts(),
          child: const Icon(Icons.refresh),
        ));
  }
}
