import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/domain/error_entity/error_entity.dart';
import 'package:flutter_client_it_product/app/presentation/app_loader.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_dialog.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_snack_bar.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_button.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_field.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';

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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) {
          final userEntity =
              state.whenOrNull(authorized: (userEntity) => userEntity);
          if (userEntity?.userState?.connectionState ==
              ConnectionState.waiting) {
            return const AppLoader();
          }
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                            val1: 'old password',
                            val2: 'new password',
                            onPressed: ((oldPassword, newPassword) =>
                                context.read<AuthCubit>().passwordUpdate(
                                      oldPassword: oldPassword,
                                      newPassword: newPassword,
                                    )),
                          ),
                        );
                      },
                      child: const Text('Update password'),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                            val1: 'username',
                            val2: 'email',
                            onPressed: ((username, email) =>
                                context.read<AuthCubit>().userUpdate(
                                      username: username,
                                      email: email,
                                    )),
                          ),
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
