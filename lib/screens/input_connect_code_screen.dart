import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import './yes_no_screen.dart';
import '../models/user.dart';

class InputConnectCodeScreen extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("コード入力画面"),
      ),
      body: Center(
          child: Column(children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: 'コネクトコードを入力', hintStyle: TextStyle(color: Colors.grey)),
        ),
        TextButton(
            onPressed: () async {
              await YesNoRepository().connect(controller.text, user);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => YesNoScreen()));
            },
            child: Text("登録する")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("キャンセル"))
      ])),
    );
  }
}
