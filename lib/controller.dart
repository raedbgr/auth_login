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
  ALuser currentAuthUser = ALuser();
  String? name;
  String? email;
  String? pwd;

  signUp(String username, String emailAddress, String password, ctx) async {
    showDialog(
      context: ctx,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      name = username;
      email = emailAddress;
      pwd = password;

      User? userCred = userCredential.user;
      await userCred?.sendEmailVerification();
      Get.back();
      Get.to(VerifyPage());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar =
        SnackBar(content: Text('The password provided is too weak.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(
            content: Text('The account already exists for that email.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  addUserDoc() async {
    DateTime dateTime = DateTime.now();
    String formattedDateTime = DateFormat('yy-MM-dd HH:mm:ss').format(dateTime);

    CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');

    DocumentReference userDocRef = usersRef.doc(); // Create a document reference

    String uid = userDocRef.id;

    await userDocRef.set({
      'uid': uid, // Include the UID in the document
      'isAdmin': false,
      'username': name,
      'email': email,
      'pwd': pwd,
      'date': formattedDateTime,
      'coins': 10,
    });

    currentUser.uid = uid;
    currentUser.isAdmin = false;
    currentUser.username = name;
    currentUser.email = email;
    currentUser.pwd = pwd;
    currentUser.date = formattedDateTime;
    currentUser.coins = 10;
    userList.add(currentUser);
  }

  fetchCurrentAuthUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final DocumentSnapshot userDoc = snapshot.docs.first;
          currentAuthUser.uid = userDoc['uid'];
          currentAuthUser.isAdmin = userDoc['isAdmin'];
          currentAuthUser.username = userDoc['username'];
          currentAuthUser.email = userDoc['email'];
          currentAuthUser.pwd = userDoc['pwd'];
          currentAuthUser.date = userDoc['date'];
          currentAuthUser.coins = userDoc['coins'];
        }
      }
    } catch (e) {
      print(e);
    }
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

  Future resetPassword (String emailAddress, ctx, controller) async {
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
        addUserDoc();
        fetchCurrentAuthUser();
        Get.offAll(HomePage());
      }
    }
  }

  Future<void> updateUsername(String newUsername) async {

    try {
      // final User? user = FirebaseAuth.instance.currentUser;
      if (currentAuthUser != null && currentAuthUser.coins! > 3) {
        // Update the username in the Firestore document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentAuthUser.uid)
            .update({'username': newUsername, 'coins': FieldValue.increment(-3),});

        // Update the username in the userList
        final ALuser? loggedInUser = userList.firstWhere(
              (ALuser user) => user.uid == currentAuthUser.uid
        );

        if (loggedInUser != null) {
          loggedInUser.username = newUsername;
          loggedInUser.coins = (loggedInUser.coins ?? 0) - 3;
        }

        // Update the currentAuthUser if the username matches
        currentAuthUser.username = newUsername;
        currentAuthUser.coins = (currentAuthUser.coins ?? 0) - 3;

        update(); // Notify GetX that the data has changed
      }
    } catch (e) {
      print(e);
    }
  }
}
