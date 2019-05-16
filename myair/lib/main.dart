import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myair/detail.dart';
import 'camera.dart';

void main() {
  runApp(MyAir());
}

class MyAir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAir',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ScanPage(),
        '/details': (context) => DetailPage(),
      }
    );
  }
}
