import 'package:flutter_login/CoreRouter/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerApp, // variable tipo GoROuter
      debugShowCheckedModeBanner: false,
    );
  }
}