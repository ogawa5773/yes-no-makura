import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String id;
  String code;
  bool hasDesire;
  String? partnerRef;

  User(this.id, this.code, this.hasDesire, this.partnerRef);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    User user = User.fromJson(documentSnapshot.data()!);
    user.id = documentSnapshot.id;
    return user;
  }
}

User _$UserFromJson(Map<String, dynamic> json) {
  return User(json['id'] as String, json['code'] as String,
      json['hasDesire'] as bool, json['partnerRef'] as String?);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hasDesire': instance.hasDesire,
      'partnerRef': instance.partnerRef,
    };
