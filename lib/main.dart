import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:yesnomakura/yes_no_repository.dart';
import './screens/yes_no_screen.dart';
import './screens/display_connect_code_screen.dart';

void main() async {
  Intl.defaultLocale = 'jp_JP';
  await initializeDateFormatting('jp_JP');
  runApp(YesNoApp());
}

class YesNoApp extends StatefulWidget {
  @override
  _YesNoApp createState() => _YesNoApp();
}

class _YesNoApp extends State<YesNoApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _deviceInfo = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String deviceData = '';

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

    // if (!mounted) return
    setState(() {
      _deviceInfo = deviceData;
    });

    YesNoRepository().registerDeviceInfo(_deviceInfo);
  }

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

    YesNoRepository().partnerIsConnected(_deviceInfo).then((isConnected) {
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
