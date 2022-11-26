import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_button.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_field.dart';

import '../domain/auth_state/auth_cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final userEntity =
              state.whenOrNull(authorized: (userEntity) => userEntity);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child:
                          Text(userEntity?.username.split('').first ?? 'None'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text(userEntity?.username ?? ''),
                        Text(userEntity?.email ?? ''),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Update password'),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const _UserUpdateDialog(),
                        );
                      },
                      child: const Text('Update data'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UserUpdateDialog extends StatefulWidget {
  const _UserUpdateDialog({Key? key}) : super(key: key);

  @override
  State<_UserUpdateDialog> createState() => __UserUpdateDialogState();
}

class __UserUpdateDialogState extends State<_UserUpdateDialog> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                  controller: usernameController, labelText: 'username'),
              const SizedBox(height: 16),
              AppTextField(controller: emailController, labelText: 'email'),
              const SizedBox(height: 16),
              AppTextButton(
                  onPressed: () {
                    context.read<AuthCubit>().userUpdate(
                        username: usernameController.text,
                        email: emailController.text);
                  },
                  text: 'Apply'),
            ],
          ),
        ),
      ],
    );
  }
}
