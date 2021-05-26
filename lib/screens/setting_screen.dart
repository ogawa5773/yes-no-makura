import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import '../models/user.dart';
import './display_connect_code_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () async {
              await YesNoRepository().unconnect(user);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => DisplayConnectCodeScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text("コネクト解除"),
            style: TextButton.styleFrom(primary: Colors.pink[200])),
      ),
    );
  }
}
