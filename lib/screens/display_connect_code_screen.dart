import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './input_connect_code_screen.dart';
import '../models/user.dart';

class DisplayConnectCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("コード入力画面"),
      ),
      body: Center(
          child: Column(children: [
        Text(user.code),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => InputConnectCodeScreen()));
            },
            child: Text("コードを入力する"))
      ])),
    );
  }
}
