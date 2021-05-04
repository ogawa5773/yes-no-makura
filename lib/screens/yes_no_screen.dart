import 'package:flutter/material.dart';
import './setting_screen.dart';

class YesNoScreen extends StatefulWidget {
  _YesNoScreen createState() => _YesNoScreen();
}

class _YesNoScreen extends State<YesNoScreen> {
  bool partnerCondition = false;
  bool myCondition = false;

  @override
  void initState() {
    super.initState();

    // TODO リポジトリの作成（相手の意志を取得）
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
        // TODO myConditionに紐づいた文言や画像を表示
        child: Text("aaa"),
        onPressed: () {
          setState(() {
            myCondition = !myCondition;
          });
        },
      ),
    );
  }
}
