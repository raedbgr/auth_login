import 'package:auth_login/home/profile.dart';
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
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        child: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle_outlined, color: Colors.white,),
                  title: Text('Profile', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Get.to(Profile());
                  },
                )
              ],
            ),
          ),
        ),
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
