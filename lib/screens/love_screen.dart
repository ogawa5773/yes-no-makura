import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class LoveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Spring.blink(
          child: Image.asset(
            'assets/heart.png',
            color: Colors.pink[50],
          ),
        ),
      ),
    );
  }
}
