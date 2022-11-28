import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_it_product/app/di/init_di.dart';
import 'package:flutter_client_it_product/app/domain/app_builder.dart';
import 'package:flutter_client_it_product/app/presentation/root_screen.dart';
import 'package:flutter_client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter_client_it_product/feature/posts/domain/post_repository.dart';
import 'package:flutter_client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
      child: MaterialApp(
        home: RootScreen(),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              PostCubit(locator.get<PostRepository>(), locator.get<AuthCubit>())
                ..fetchPosts(),
        ),
      ],
      child: child,
    );
  }
}
