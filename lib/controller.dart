import 'dart:async';
import 'package:auth_login/Models/user.dart';
import 'package:auth_login/auth/verify_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home/home_page.dart';

class MyController extends GetxController {
  List<ALuser> userList = <ALuser>[];
  ALuser currentUser = ALuser();
  final user = FirebaseAuth.instance.currentUser;
  bool isVerified = false;
  Timer? timer;


  signUp(String username, String emailAddress, String password, ctx) async {
    showDialog(
        context: ctx,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? userCred = userCredential.user;
      await userCred?.sendEmailVerification();

      // from here
      DateTime dateTime = DateTime.now();
      String formatedDateTime =
      DateFormat('yy-MM-dd HH:mm:ss').format(dateTime);

      CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

      usersRef.add({
        'uid': usersRef.id,
        'isAdmin': false,
        'username': username,
        'email': emailAddress,
        'pwd': password,
        'date': formatedDateTime,
        'coins': 10,
      });

      currentUser.uid = usersRef.id;
      currentUser.isAdmin = false;
      currentUser.username = username;
      currentUser.email = emailAddress;
      currentUser.pwd = password;
      currentUser.date = formatedDateTime;
      currentUser.coins = 0;
      userList.add(currentUser);
      print(currentUser);
      // to here

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
    Get.back();
    Get.to(VerifyPage());
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
      UserCredential userCredential = await FirebaseAuth.instance
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
    Get.back();
    Get.offAll(HomePage());
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

  sendVerification () async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  Future checkEmailVerified () async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      isVerified = currentUser.emailVerified;
      update();
      if (isVerified) {
        timer?.cancel();
        Get.offAll(HomePage());
      };
    }
  }

}
