import 'package:flutter/material.dart';
import './input_connect_code_screen.dart';

class DisplayConnectCodeScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    // TODO リポジトリの作成（自分のコネクトコードを取得

    return Center(
        child: Column(children: [
      Text("マイコード"),
      TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => InputConnectCodeScreen()));
          },
          child: Text("コードを入力する"))
    ]));
  }
}
