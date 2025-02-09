import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(BhargavaSwaraApp());
}

class BhargavaSwaraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhargava Swara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
