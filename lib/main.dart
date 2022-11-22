import 'package:flutter_client_it_product/app/presentation/main_app_runner.dart';
import 'package:flutter_client_it_product/app/presentation/main_app_builder.dart';

void main() {
  const env = String.fromEnvironment('env', defaultValue: 'prod');
  const runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
