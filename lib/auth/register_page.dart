import 'package:auth_login/auth/login_page.dart';
import 'package:auth_login/components/animated_text.dart';
import 'package:auth_login/components/text_field.dart';
import 'package:auth_login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final MyController _myController = Get.put(MyController());
  bool _pwdVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 150,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const MyAnimatedText(text: 'Let\'s create an account'),
                  const SizedBox(height: 25),
                  // username Controller
                  MyTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                  ),
                  const SizedBox(height: 10),
                  // email controller
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  // password controller
                  TextField(
                    controller: _pwdController,
                    obscureText: _pwdVisibility,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        suffixIcon: _pwdVisibility
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pwdVisibility = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey.shade600,
                                ))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pwdVisibility = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.visibility,
                                  color: Colors.grey.shade600,
                                ))),
                  ),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () {
                      _myController.signUp(_usernameController.text,
                          _emailController.text, _pwdController.text, context);
                      Get.offAll(LoginPage());
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
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(LoginPage());
                      },
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
