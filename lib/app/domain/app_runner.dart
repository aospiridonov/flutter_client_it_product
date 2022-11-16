import 'package:flutter_client_it_product/app/domain/app_builder.dart';

abstract class AppRunner {
  Future<void> preloadData();
  Future<void> run(AppBuilder appBuilder);
}
