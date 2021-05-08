import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    user = context.watch<User>();

    // TODO 相手の意志を取得
    // Repository.getCondition().then((value) {
    //   setState(() {
    //     partnerCondition = value;
    //   });
    // });
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
      // TODO partnerConditionに紐づいた画像を表示
      // またpartnerConditionをリアルタイムに取得できるようにする
      body: Text("aaaa"),
      floatingActionButton: FloatingActionButton(
        child: Text("user.hasDesire"),
        onPressed: () {
          // TODO 自分のdesireの切り替え
        },
      ),
    );
  }
}
