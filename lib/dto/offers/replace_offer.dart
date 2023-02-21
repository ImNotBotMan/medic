// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReplaceOfferRequest {
  final String userId;
  String offerTypeId;
  final String apparatId;
  final String description;
  final String companyId;
  final DateTime dateTime;

  ReplaceOfferRequest({
    required this.userId,
    this.offerTypeId = "2",
    required this.apparatId,
    required this.description,
    required this.companyId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'offer_type_id': offerTypeId,
      'apparat_id': apparatId,
      'description': description,
      'company_id': companyId,
      'date_time': dateTime,
    };
  }

  factory ReplaceOfferRequest.fromMap(Map<String, dynamic> map) {
    return ReplaceOfferRequest(
      userId: map['user_id'] as String,
      // offerTypeId: map['offer_type_id'] as String,
      apparatId: map['apparat_id'] as String,
      description: map['description'] as String,
      companyId: map['company_id'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReplaceOfferRequest.fromJson(String source) =>
      ReplaceOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
