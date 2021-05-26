import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Partner {
  String id;
  String code;
  bool hasDesire;
  String? partnerRef;

  Partner(this.id, this.code, this.hasDesire, this.partnerRef);

  Map<dynamic, dynamic> toJson() => _$PartnerToJson(this);

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
  factory Partner.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Partner partner = Partner.fromJson(documentSnapshot.data()!);
    partner.id = documentSnapshot.id;
    return partner;
  }
}

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return Partner(json['id'] as String, json['code'] as String,
      json['hasDesire'] as bool, json['partnerRef'] as String?);
}

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hasDesire': instance.hasDesire,
      'partnerRef': instance.partnerRef,
    };
