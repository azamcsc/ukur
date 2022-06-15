import 'dart:io';
import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  //debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginDemo(),
    );
  }
}

