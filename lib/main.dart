import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('مكتبة المناهج العراقية')),
        body: const Center(
          child: Text('مرحباً بك في تطبيق المناهج!'),
        ),
      ),
    );
  }
}
