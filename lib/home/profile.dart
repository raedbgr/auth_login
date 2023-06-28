import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          const Center(
            child: Icon(Icons.person, size: 120,),
          ),
          const SizedBox(height: 10,),
          Center(
            child: Text(
              user!.email!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'username',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: Colors.grey.shade500,))
                  ],
                ),
                Text('usename', style: TextStyle(color: Colors.grey.shade700),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}