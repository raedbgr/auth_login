import 'package:auth_login/auth/register_page.dart';
import 'package:auth_login/components/animated_text.dart';
import 'package:auth_login/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
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
                const MyAnimatedText(text: 'Welcome back'),
                const SizedBox(height: 25),
                // email controller
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                // password controller
                TextField(
                  controller: _passwordController,
                  obscureText: _passVisibility,
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
                      suffixIcon: _passVisibility
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _passVisibility = false;
                                });
                              },
                              icon: Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _passVisibility = true;
                                });
                              },
                              icon: Icon(Icons.visibility_off))),
                ),
                const SizedBox(height: 25),
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
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
                    'Don\'t have an account ?',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(RegisterPage());
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
