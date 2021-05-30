import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class LoveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Spring.blink(
          animDuration: Duration(seconds: 2),
          child: Image.asset(
            'assets/heart.png',
            color: Colors.pink[150],
          ),
        ),
      ),
    );
  }
}
