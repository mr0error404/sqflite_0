import 'package:flutter/material.dart';
import 'package:sqflite_0/addnote.dart';
import 'package:sqflite_0/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {"addnotes" : (context) => AddNote()},
    );
  }
}