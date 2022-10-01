import 'package:dyeus_phone_signin/auth_screen.dart';
import 'package:dyeus_phone_signin/home_screen.dart';
import 'package:dyeus_phone_signin/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
