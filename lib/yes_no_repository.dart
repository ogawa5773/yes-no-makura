import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yesnomakura/models/user.dart';

class YesNoRepository {
  Future<bool> partnerIsConnected(User user) async {
    bool isConnected = false;
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.id);

    await docRef.get().then((doc) => {
          if (doc.exists) {isConnected = true} else {isConnected = false}
        });

    return isConnected;
  }

  Future<bool> getPartnerDesire(User user) async {
    final db = FirebaseFirestore.instance;
    User? partner;

    await db
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

  Future<User> initializeOrCreateUser(String deviceID) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(deviceID);
    User? user;

    await docRef.get().then((doc) => {
          if (doc.exists)
            {user = doc.data() as User}
          else
            {
              // TODO: codeを発行する
              user = FirebaseFirestore.instance
                  .collection('users')
                  .doc(deviceID)
                  .set({
                'id': deviceID,
                'hasDesire': false,
                'code': 'aiueo',
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
                partner = doc.data() as User;
              })
            });

    db
        .collection('users')
        .doc(user.id)
        .update({'partnerRef': 'users/${partner!.id}'});
    db
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
                partner = doc.data() as User;
              })
            });

    db.collection('users').doc(user.id).update({'partnerRef': null});
    db.collection('users').doc(partner!.id).update({'partnerRef': null});
  }
}
