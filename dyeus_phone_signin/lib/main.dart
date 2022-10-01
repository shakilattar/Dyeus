import 'package:dyeus_phone_signin/auth_screen.dart';
import 'package:dyeus_phone_signin/home_screen.dart';
import 'package:dyeus_phone_signin/toggle_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: AuthScreen(),
    );
  }
}
