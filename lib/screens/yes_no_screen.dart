import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnomakura/models/partner.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import '../models/user.dart';
import './setting_screen.dart';
import './rain_screen.dart';
import './love_screen.dart';

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
            },
          ),
        ],
      ),
      body: partner.hasDesire ? LoveScreen() : RainScreen(),
      floatingActionButton: FloatingActionButton(
        child: Text("${user.hasDesire.toString()}"),
        onPressed: () {
          YesNoRepository().switchMyDesire(user);
        },
      ),
    );
  }
}
