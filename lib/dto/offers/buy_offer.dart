// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuyOfferRequest {
  final String userId;
  String offerTypeID;
  final String additionalId;
  final DateTime dateTime;

  BuyOfferRequest({
    required this.userId,
    this.offerTypeID = '1',
    required this.additionalId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'offer_type_id': offerTypeID,
      'additional_offer_data': additionalId,
      'date_time': dateTime,
    };
  }

  factory BuyOfferRequest.fromMap(Map<String, dynamic> map) {
    return BuyOfferRequest(
      userId: map['user_id'] as String,
      // offerTypeID: map['offer_type_id'] as String,
      additionalId: map['additional_offer_data'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyOfferRequest.fromJson(String source) =>
      BuyOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
