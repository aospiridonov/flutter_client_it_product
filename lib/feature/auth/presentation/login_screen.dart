import 'package:flutter/material.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_button.dart';
import 'package:flutter_client_it_product/app/presentation/components/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen'),
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
                  controller: controllerPassword,
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      print('Ok');
                    }
                  },
                  text: 'Sign In',
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      print('Ok');
                    }
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
}
