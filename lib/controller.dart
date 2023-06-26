import 'package:auth_login/main.dart';
import 'package:auth_login/Models/user.dart';
import 'package:auth_login/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/login_page.dart';

class MyController extends GetxController {
  List<ALuser> userList = <ALuser>[];
  ALuser currentUser = ALuser();
  final user = FirebaseAuth.instance.currentUser!;

  signUp (String username, String emailAddress, String password) async {
    showDialog(context: navigatorKey.currentContext!, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      DateTime dateTime = DateTime.now();

      currentUser.id = user.uid;
      currentUser.isAdmin = false;
      currentUser.username = username;
      currentUser.email = emailAddress;
      currentUser.pwd = password;
      currentUser.date = dateTime as String?;
      currentUser.coins = 10;
      userList.add(currentUser);

      Get.offAll(LoginPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    Navigator.pop(navigatorKey.currentContext!);
  }

  signIn (String emailAddress, String password) async {
    showDialog(context: navigatorKey.currentContext!, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      Get.offAll(HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    Navigator.pop(navigatorKey.currentContext!);
  }
}