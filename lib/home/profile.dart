import 'package:auth_login/components/alert_dialog.dart';
import 'package:auth_login/components/text_field.dart';
import 'package:auth_login/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  final MyController myController = Get.put(MyController());

  @override
  void initState () {
    super.initState();
    myController.fetchCurrentAuthUser();
  }

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
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Center(
            child: Icon(
              Icons.person,
              size: 120,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${myController.currentAuthUser.email}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Details',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Row(
                  children: [
                    Text(
                      '${myController.currentAuthUser.coins}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.grey.shade900,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'username :',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${myController.currentAuthUser.username}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      if (myController.currentAuthUser.coins != null && myController.currentAuthUser.coins! > 3) {
                        showDialog(context: context, builder: (_) {
                          return MyDialog();
                        });
                      } else {
                        const snackBar = SnackBar(content: Text('You don\'t have enough coins'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey.shade700,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${myController.currentAuthUser.uid}',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
