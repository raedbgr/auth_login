import 'package:auth_login/main.dart';
import 'package:auth_login/Models/user.dart';
import 'package:auth_login/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/login_page.dart';

// void showLoading(){
//   showDialog(
//
//       context: navigatorKey.currentContext!,
//       builder: (_) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       });
// }

class MyController extends GetxController {
  List<ALuser> userList = <ALuser>[];
  ALuser currentUser = ALuser();
  final user = FirebaseAuth.instance.currentUser;

  signUp(String username, String emailAddress, String password, ctx) async {
    showDialog(
        context: ctx,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      DateTime dateTime = DateTime.now();

      currentUser.isAdmin = false;
      currentUser.username = username;
      currentUser.email = emailAddress;
      currentUser.pwd = password;
      // currentUser.date = dateTime as String?;
      currentUser.coins = 10;
      userList.add(currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    Navigator.pop(ctx);
  }

  signIn(String emailAddress, String password, ctx) async {
    showDialog(
        context: ctx,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    Navigator.pop(ctx);
  }
}
