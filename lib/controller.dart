import 'package:auth_login/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      String formatedDateTime =
      DateFormat('yy-MM-dd HH:mm:ss').format(dateTime);

      currentUser.isAdmin = false;
      currentUser.username = username;
      currentUser.email = emailAddress;
      currentUser.pwd = password;
      currentUser.date = formatedDateTime;
      currentUser.coins = 10;
      userList.add(currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(content: Text('The password provided is too weak.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(content: Text('The account already exists for that email.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
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
        const snackBar = SnackBar(content: Text('No user found for that email.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        const snackBar = SnackBar(content: Text('Wrong password provided for that user.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    }

    Navigator.pop(ctx);
  }

  Future resetPasswrd (String emailAddress, ctx, controller) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      showDialog(
        context: ctx,
        builder: (ctx) {
          return const AlertDialog(
            content: Text('Password reset link sent to your email'),
          );
        },
      );
      controller.clear();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }
}
