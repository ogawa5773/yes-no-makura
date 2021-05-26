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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'コネクトコードを入力',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            TextButton(
              onPressed: () async {
                await YesNoRepository().connect(controller.text, user);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => YesNoScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("コネクトする"),
              style: TextButton.styleFrom(
                primary: Colors.pink[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
