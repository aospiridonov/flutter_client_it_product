import 'package:flutter/cupertino.dart';
import 'package:flutter_client_it_product/app/domain/app_builder.dart';
import 'package:flutter_client_it_product/app/domain/app_runner.dart';

class MainAppRunner implements AppRunner {
  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();
    // init app
    // init di
    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(appBuilder.buildApp());
  }
}
