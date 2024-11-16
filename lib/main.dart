import 'package:flutter/material.dart';
import 'package:to_do_app/to_do_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("To Do App"),
        ),
        body: const ToDoPage(),
      ),
    );
  }
}
