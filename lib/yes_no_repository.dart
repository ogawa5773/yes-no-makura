import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yesnomakura/models/user.dart';

class YesNoRepository {
  Future<bool> partnerIsConnected(User user) async {
    bool isConnected = false;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .get()
        .then((doc) => {
              if (doc.data()!["partnerRef"] == null)
                {isConnected = false}
              else
                {isConnected = true}
            });

    return isConnected;
  }

  Future<void> switchMyDesire(User user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'hasDesire': !user.hasDesire});
  }

  Future<bool> getPartnerDesire(User user) async {
    final db = FirebaseFirestore.instance;
    User? partner;

    db
        .collection('users')
        .where('partnerRef', isEqualTo: '/users/${user.id}')
        .snapshots()
        .listen((snapshot) => {
              snapshot.docs.forEach((doc) {
                partner = doc.data() as User;
              })
            });

    return partner!.hasDesire;
  }

  User _toUser(Map<String, dynamic> data) {
    return User(
        id: data['id'], code: data['code'], hasDesire: data['hasDesire']);
  }

  Future<User> initializeOrCreateUser(String deviceID) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(deviceID);
    User? user;

    await docRef.get().then((doc) => {
          if (doc.exists)
            {user = _toUser(new Map<String, dynamic>.from(doc.data()!))}
          else
            {
              user = FirebaseFirestore.instance
                  .collection('users')
                  .doc(deviceID)
                  .set({
                'id': deviceID,
                'hasDesire': false,
                'code': randomString(6),
                'partnerRef': null
              }) as User
            }
        });

    return user!;
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
                partner = _toUser(new Map<String, dynamic>.from(doc.data()));
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
                partner = _toUser(new Map<String, dynamic>.from(doc.data()));
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
