import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './input_connect_code_screen.dart';
import '../models/user.dart';

class DisplayConnectCodeScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final User user = context.watch<User>();
    return Center(
        child: Column(children: [
      Text(user.code),
      TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => InputConnectCodeScreen()));
          },
          child: Text("コードを入力する"))
    ]));
  }
}
