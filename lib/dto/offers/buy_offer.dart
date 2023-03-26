// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:server/dto/offers/base_offer.dart';
import 'package:server/dto/user/user.dart';

class ButOfferReport implements BaseReport {
  final BuyOfferRequest offer;
  final User user;

  ButOfferReport({
    required this.offer,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offer': offer.toMap(),
      'user': user.toMap(),
    };
  }

  factory ButOfferReport.fromMap(Map<String, dynamic> map) {
    return ButOfferReport(
      offer: BuyOfferRequest.fromMap(map['offer'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ButOfferReport.fromJson(String source) => ButOfferReport.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BuyOfferRequest implements BaseOffer {
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
      'date_time': dateTime.toString(),
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

  @override
  String toJson() => json.encode(toMap());

  factory BuyOfferRequest.fromJson(String source) =>
      BuyOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
