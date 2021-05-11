import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import './setting_screen.dart';
import '../models/user.dart';

class YesNoScreen extends StatefulWidget {
  _YesNoScreen createState() => _YesNoScreen();
}

class _YesNoScreen extends State<YesNoScreen> {
  bool partnerCondition = false;
  User? user;

  // https://qiita.com/HiromitsuFukuda/items/10a63a7b347db1712a86
  // providerから値を取得する上でcontextが必要になるため本来ならinitStateで実行するものをここで実行している
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = context.watch<User>();

    YesNoRepository().getPartnerDesire(user!).then((value) {
      setState(() {
        partnerCondition = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: partnerCondition ? Icon(Icons.arrow_back_ios) : Icon(Icons.android),
      // body: partnerCondition ? Image.network("aaa") : Image.network("bbb"),
      floatingActionButton: FloatingActionButton(
        child: Text("user.hasDesire"),
        onPressed: () async {
          await YesNoRepository().switchMyDesire(user!);
          // TODO リビルド
        },
      ),
    );
  }
}
