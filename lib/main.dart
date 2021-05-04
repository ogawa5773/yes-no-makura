import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

    // TODO リポジトリの作成
    // Repository().partnerIsConnected().then((isConnected) {
    //   if (isConnected) {
    //     // TODO YesNo画面の作成
    //     Navigator.of(context)
    //         .pushReplacement(MaterialPageRoute(builder: (_) => A));
    //   } else {
    //     // TODO コネクト画面の作成
    //     Navigator.of(context)
    //         .pushReplacement(MaterialPageRoute(builder: (_) => B));
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
