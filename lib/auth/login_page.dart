import 'package:auth_login/auth/forgot_password_page.dart';
import 'package:auth_login/auth/register_page.dart';
import 'package:auth_login/components/animated_text.dart';
import 'package:auth_login/components/square_tile.dart';
import 'package:auth_login/components/text_field.dart';
import 'package:auth_login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    size: 100,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(ForgotPassPage());
                          },
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty && _pwdController.text.isEmpty) {
                        const snackBar = SnackBar(content: Text('Please enter your fields !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _myController.signIn(
                            _emailController.text, _pwdController.text, context);
                      }
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
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //   child: Row(
                  //     children: [
                  //       Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                  //       const Padding(
                  //         padding: EdgeInsets.all(10),
                  //         child: Text('Or login with'),
                  //       ),
                  //       Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 25,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     MySquareTile(imagePath: '/Google.png',),
                  //     SizedBox(width: 25,),
                  //     MySquareTile(imagePath: '/Facebook.png'),
                  //   ],
                  // ),
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
      ),
    );
  }
}
