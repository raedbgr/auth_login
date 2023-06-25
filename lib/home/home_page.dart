import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Home'),
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
      ),
    );
  }
}