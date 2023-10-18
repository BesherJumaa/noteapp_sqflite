import 'package:flutter/material.dart';

import 'package:noteapp_sqflite/addnotes.dart';
import 'package:noteapp_sqflite/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "addnotes": (context) => AddNotes(),
        "home": (context) => Home(),
      },
    );
  }
}
