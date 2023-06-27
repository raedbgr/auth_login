import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Profile'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
    );
  }
}