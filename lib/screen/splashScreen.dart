import 'package:flutter/material.dart';
import 'package:sub_space/screen/blogList.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => BlogList()));
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
      body: Center(
        child: Image.asset('assets/icon.PNG'),
      ),
    );
  }
}
