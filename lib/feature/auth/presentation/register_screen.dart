import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_button.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_field.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final controllerLogin = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPassword2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterScreen'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: controllerLogin,
                  labelText: 'Login',
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controllerEmail,
                  labelText: 'Email',
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controllerPassword,
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controllerPassword2,
                  labelText: 'Repeat password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {
                    if (formKey.currentState?.validate() != true) return;
                    if (controllerPassword.text != controllerPassword2.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password mismatch')));
                      return;
                    }
                    _onTapToSignUp(context.read<AuthCubit>());
                    Navigator.of(context).pop();
                  },
                  text: 'Registration',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapToSignUp(AuthCubit authCubit) => authCubit.signUp(
        username: controllerLogin.text,
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
}
