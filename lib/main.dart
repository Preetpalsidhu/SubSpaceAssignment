import 'package:flutter/material.dart';
import 'package:sub_space/screen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeData(
      // ),
      home: SplashScreen(),
    );
  }
}
