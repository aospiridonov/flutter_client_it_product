import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter_client_it_product/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter_client_it_product/feature/auth/presentation/user_screen.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<AuthCubit>().getProfile(),
          child: const Icon(Icons.refresh),
        ));
  }
}
