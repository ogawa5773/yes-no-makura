import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './yes_no_repository.dart';
import './models/user.dart';
import './models/partner.dart';
import './screens/yes_no_screen.dart';
import './screens/display_connect_code_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'jp_JP';
  await initializeDateFormatting('jp_JP');

  String deviceData = '';
  Future<void> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
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

  await initPlatformState();

  runApp(YesNoApp(deviceData));
}

class YesNoApp extends StatelessWidget {
  final String deviceData;
  YesNoApp(this.deviceData);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          create: (_) => YesNoRepository().initializeOrFindUser(deviceData),
          initialData: User('', '', false, null),
        ),
        StreamProvider<Partner>(
          create: (_) => YesNoRepository().getPartner(deviceData),
          initialData: Partner('', '', false, null),
        ),
      ],
      child: MaterialApp(
        title: 'YesNo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink[50],
          accentColor: Colors.pink[50],
        ),
        home: LoadPartner(),
      ),
    );
  }
}

class LoadPartner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:
          user.partnerRef != null ? YesNoScreen() : DisplayConnectCodeScreen(),
    );
  }
}
