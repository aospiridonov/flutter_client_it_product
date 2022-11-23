import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter_client_it_product/feature/auth/domain/entities/user_entity/user_entity.dart';

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
            onPressed: () => context.read<AuthCubit>().logOut(),
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(child: Text(userEntity.username)),
    );
  }
}
