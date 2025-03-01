import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(BhargavaSwaraApp());
}

class BhargavaSwaraApp extends StatelessWidget {
  const BhargavaSwaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhargava Swara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
