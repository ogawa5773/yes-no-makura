import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import './screens/yes_no_screen.dart';
import './screens/display_connect_code_screen.dart';

void main() async {
  Intl.defaultLocale = 'jp_JP';
  await initializeDateFormatting('jp_JP');
  runApp(YesNoApp());
}

class YesNoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YesNo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _LoadPartner());
  }
}

class _LoadPartner extends StatefulWidget {
  @override
  __LoadPartner createState() => __LoadPartner();
}

class __LoadPartner extends State<_LoadPartner> {
  Error? _error;

  @override
  void initState() {
    super.initState();

    // TODO リポジトリの作成（コネクト作業が完了しているか取得）
    // Repository().partnerIsConnected().then((isConnected) {
    //   if (isConnected) {
    //     // TODO YesNo画面の作成
    //     Navigator.of(context)
    //         .pushReplacement(MaterialPageRoute(builder: (_) => YesNoScreen()));
    //   } else {
    //     // TODO コネクト画面の作成
    //     Navigator.of(context)
    //         .pushReplacement(MaterialPageRoute(builder: (_) => displayConnectCodeScreen()));
    //   }
    // }).catchError((e) {
    //   setState(() {
    //     _error = e;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: (_error == null)
            ? CircularProgressIndicator()
            : Text(_error.toString()),
      ),
    );
  }
}
