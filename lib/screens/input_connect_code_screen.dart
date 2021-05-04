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
            // TODO Repositoryの作成（コネクト処理）
            // await
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
