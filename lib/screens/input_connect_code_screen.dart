import 'package:flutter/material.dart';
import './yes_no_screen.dart';

class InputConnectCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      TextField(),
      TextButton(
          onPressed: () {
            // TODO コネクト処理
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => YesNoScreen()));
          },
          child: Text("登録する")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("キャンセル"))
    ]));
  }
}
