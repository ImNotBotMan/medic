// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RemoveOfferRequest {
  final String userId;
  final String apparatId;
  final String offerTypeId;
  final DateTime dateTime;

  RemoveOfferRequest({
    required this.userId,
    required this.apparatId,
    this.offerTypeId = '3',
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'apparat_id': apparatId,
      'offer_type_id': offerTypeId,
      'date_time': dateTime,
    };
  }

  factory RemoveOfferRequest.fromMap(Map<String, dynamic> map) {
    return RemoveOfferRequest(
      userId: map['user_id'] as String,
      apparatId: map['apparat_id'] as String,
      // offerTypeId: map['offer_type_id'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveOfferRequest.fromJson(String source) =>
      RemoveOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
