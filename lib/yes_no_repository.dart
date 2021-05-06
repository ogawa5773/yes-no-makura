import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yesnomakura/models/user.dart';

class YesNoRepository {
  Future<bool> partnerIsConnected(User user) async {
    bool isConnected = false;
    final docRef = FirebaseFirestore.instance.collection('connects').doc();
    // TODO: user.idで検索かける
    docRef.get().then((doc) => {isConnected = doc.exists});

    return isConnected;
  }

  // TODO リアルタイム
  Future<bool> getPartnerDesire(User user) async {
    // TODO: user.idでconnctsを検索かけパートナーを取得
    final partner = User(id: '2', code: '2', hasDesire: true);

    return partner.hasDesire;
  }

  Future<void> registerDeviceInfo(String deviceID) async {
    final date = DateTime.now().toLocal().toIso8601String();
    FirebaseFirestore.instance
        .collection('users')
        .doc(deviceID)
        .set({'date': date});
  }

  Future<void> connect(String connectCode, User user) async {
    final date = DateTime.now().toLocal().toIso8601String();
    // TODO パートナーユーザーを取得する
    final host = User(id: '2', code: '2', hasDesire: true);
    FirebaseFirestore.instance
        .collection('partners')
        .doc()
        .set({'host_id': host.id, 'guest_id': user.id, 'date': date});
  }

  Future<void> unconnect(User user) async {
    final docRef = FirebaseFirestore.instance.collection('connects').doc();
    // TODO: user.idで検索かけた上で削除
    docRef.delete();
  }
}
