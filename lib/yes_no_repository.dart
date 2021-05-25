import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yesnomakura/models/user.dart';
import 'package:yesnomakura/models/partner.dart';

class YesNoRepository {
  Stream<User> initializeOrFindUser(String deviceID) {
    final ref = FirebaseFirestore.instance.collection('users');

    // 存在していなければcreate
    // TODO awaitする
    ref.doc(deviceID).get().then((doc) => {
          if (!doc.exists)
            {
              FirebaseFirestore.instance.collection('users').doc(deviceID).set({
                'id': deviceID,
                'hasDesire': false,
                'code': randomString(6),
                'partnerRef': null
              }).then((value) => {})
            }
        });

    return ref.doc(deviceID).snapshots().map((doc) => User.fromFirestore(doc));
  }

  Stream<Partner> getPartner(String deviceID) {
    // TODO 相手がいない場合の返る場合の処理
    final ref = FirebaseFirestore.instance.collection('users');

    return ref
        .where('partnerRef', isEqualTo: 'users/$deviceID')
        .snapshots()
        .map((doc) => {Partner.fromFirestore(doc.docs[0])}.first);
  }

  void switchMyDesire(User user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'hasDesire': !user.hasDesire});
  }

  Future<void> connect(String connectCode, User user) async {
    final db = FirebaseFirestore.instance;
    User? partner;

    await db
        .collection('users')
        .where('code', isEqualTo: connectCode)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                partner = User.fromFirestore(doc);
              })
            });

    await db
        .collection('users')
        .doc(user.id)
        .update({'partnerRef': 'users/${partner!.id}'});
    await db
        .collection('users')
        .doc(partner!.id)
        .update({'partnerRef': 'users/${user.id}'});
  }

  Future<void> unconnect(User user) async {
    final db = FirebaseFirestore.instance;
    User? partner;

    await db
        .collection('users')
        .where('partnerRef', isEqualTo: '/users/${user.id}')
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                partner = User.fromFirestore(doc);
              })
            });

    db.collection('users').doc(user.id).update({'partnerRef': null});
    db.collection('users').doc(partner!.id).update({'partnerRef': null});
  }
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;

  final rand = new Random();
  final codeUnits = new List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}
