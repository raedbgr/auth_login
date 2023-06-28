import 'package:auth_login/components/text_field.dart';
import 'package:auth_login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  final MyController _myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your email',
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(controller: _emailController, hintText: 'Email'),
                  const SizedBox(height: 25,),
                  MaterialButton(
                    onPressed: () {
                      _myController.resetPasswrd(_emailController.text, context, _emailController);
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}