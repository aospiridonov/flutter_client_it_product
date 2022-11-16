import 'package:flutter/material.dart';
import 'package:flutter_client_it_product/app/domain/app_builder.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello'),
        ),
      ),
    );
  }
}
