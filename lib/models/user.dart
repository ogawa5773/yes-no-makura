import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String id;
  final String code;
  final bool hasDesire;
  String? partnerRef;

  User({required this.id, required this.code, required this.hasDesire});

  void updateDesire() {
    notifyListeners();
  }
}
