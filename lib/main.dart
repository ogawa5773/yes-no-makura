import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './yes_no_repository.dart';
import './models/user.dart';
import './screens/yes_no_screen.dart';
import './screens/display_connect_code_screen.dart';

void main() async {
  Intl.defaultLocale = 'jp_JP';
  await initializeDateFormatting('jp_JP');

  // deviceIDの取得
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceData = '';
  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        deviceData = androidDeviceInfo.androidId;
      } else if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceData = iosDeviceInfo.identifierForVendor;
      }
    } on PlatformException {
      deviceData = 'Error';
    }
  }

  // TODO userの取得ないしは作成を行う
  final user = User(id: '1', code: '1', hasDesire: false);
  runApp(Provider<User>.value(value: user, child: YesNoApp()));
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

  // https://qiita.com/HiromitsuFukuda/items/10a63a7b347db1712a86
  // providerから値を取得する上でcontextが必要になるため本来ならinitStateで実行するものをここで実行している
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = context.watch<User>();

    YesNoRepository().partnerIsConnected(user).then((isConnected) {
      if (isConnected) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => YesNoScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => DisplayConnectCodeScreen()));
      }
    }).catchError((e) {
      setState(() {
        _error = e;
      });
    });
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
