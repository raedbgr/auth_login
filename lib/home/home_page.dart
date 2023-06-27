import 'package:auth_login/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Home'),
        backgroundColor: Colors.grey.shade900,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined)
        ),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(context: context, builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logged in as ',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(
                        color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
