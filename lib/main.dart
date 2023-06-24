import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      home: LoginPage(),
    );
  }
}
