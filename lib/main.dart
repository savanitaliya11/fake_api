import 'package:fake_api/screen/home_screen.dart';
import 'package:fake_api/screen/login_page.dart';
import 'package:fake_api/screen/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void setupLocator() {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Api',
      home: Registartion(),
    );
  }
}
