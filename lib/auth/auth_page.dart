import 'package:auth_login/auth/login_page.dart';
import 'package:auth_login/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_login/controller.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            myController.fetchCurrentAuthUser();
            return HomePage();
          }
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
