import 'package:flutter/material.dart';
import 'package:flutter_client_it_product/app/presentation/app_loader.dart';
import 'package:flutter_client_it_product/feature/auth/presentation/components/auth_builder.dart';
import 'package:flutter_client_it_product/feature/auth/presentation/login_screen.dart';
import 'package:flutter_client_it_product/feature/main/presentation/main_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAuthorized: (context) => const LoginScreen(),
      isWaiting: (context) => const AppLoader(),
      isAuthorized: (context, value, child) => MainScreen(userEntity: value),
    );
  }
}
