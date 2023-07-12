import 'package:auth_login/components/text_field.dart';
import 'package:auth_login/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog extends StatefulWidget {
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      title: const Text('Update username'),
      content: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyTextField(
                controller: _usernameController,
                hintText: 'username',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_usernameController != null) {
                myController.updateUsername(_usernameController.text);
                Get.back();
              } else {
                const snackBar =
                    SnackBar(content: Text('Enter you\'re new username :'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text('Update')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'))
      ],
    );
  }
}
