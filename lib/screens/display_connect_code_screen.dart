import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './input_connect_code_screen.dart';
import '../models/user.dart';

class DisplayConnectCodeScreen extends StatelessWidget {
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
            Container(
              color: Colors.pink[50],
              width: 200,
              height: 100,
              child: Text(user.code),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => InputConnectCodeScreen(),
                  ),
                );
              },
              child: Text("パートナーのコネクトコードを入力する"),
              style: TextButton.styleFrom(primary: Colors.pink[200]),
            )
          ],
        ),
      ),
    );
  }
}
