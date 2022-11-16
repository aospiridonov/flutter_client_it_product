import 'package:flutter/cupertino.dart';
import 'package:flutter_client_it_product/app/di/init_di.dart';
import 'package:flutter_client_it_product/app/domain/app_builder.dart';
import 'package:flutter_client_it_product/app/domain/app_runner.dart';

class MainAppRunner implements AppRunner {
  final String env;

  const MainAppRunner(this.env);

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();
    // init app
    initDi(env);
    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(appBuilder.buildApp());
  }
}
