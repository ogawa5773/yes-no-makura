import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YesNoRepository {
  // GET
  Future<bool> partnerIsConnected(String deviceID) async {
    bool value = false;
    final docRef = FirebaseFirestore.instance.collection('users').doc(deviceID);
    docRef.get().then((doc) => {value = doc.exists});
    // TODO パートナーを持っているかの検索

    return value;
  }

  Future<String> getConnetCode(String deviceID) async {
    // TODO 検索できなかった時から文字返らないようにする
    String value = '';
    final docRef = FirebaseFirestore.instance.collection('users').doc(deviceID);
    docRef.get().then((doc) => {value = doc.id});

    return value;
  }

  // パートナーの意思を取得（リアルタイムに）

  // POST
  Future<void> registerDeviceInfo(String deviceID) async {
    final date = DateTime.now().toLocal().toIso8601String();
    FirebaseFirestore.instance
        .collection('users')
        .doc(deviceID)
        .set({'date': date});
  }

  Future<void> connect(String connectCode, String deviceID) async {
    final date = DateTime.now().toLocal().toIso8601String();
    // TODO パートナーユーザーを取得する
    FirebaseFirestore.instance
        .collection('partners')
        .doc()
        .set({'date': 'date'});
  }

  // YesNoのデフォルト設定

  // DELETE
  // コネクト解除
}
