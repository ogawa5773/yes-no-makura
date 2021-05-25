import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnomakura/models/partner.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import './setting_screen.dart';
import '../models/user.dart';

class YesNoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final partner = Provider.of<Partner>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SettingScreen()));
              })
        ],
      ),
      body: Text("${partner.hasDesire.toString()}"),
      floatingActionButton: FloatingActionButton(
        child: Text("${user.hasDesire.toString()}"),
        onPressed: () {
          YesNoRepository().switchMyDesire(user);
        },
      ),
    );
  }
}
