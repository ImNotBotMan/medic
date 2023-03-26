// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:server/dto/apparat/apparat.dart';
import 'package:server/dto/offers/base_offer.dart';
import 'package:server/dto/user/user.dart';

class RemoveOfferReport implements BaseReport {
  final RemoveOfferRequest offer;
  final User user;
  final Apparat apparat;

  RemoveOfferReport({required this.offer, required this.user, required this.apparat});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offer': offer.toMap(),
      'user': user.toMap(),
      'apparat': apparat.toMap(),
    };
  }

  factory RemoveOfferReport.fromMap(Map<String, dynamic> map) {
    return RemoveOfferReport(
      offer: RemoveOfferRequest.fromMap(map['offer'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      apparat: Apparat.fromMap(map['apparat'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveOfferReport.fromJson(String source) =>
      RemoveOfferReport.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RemoveOfferRequest implements BaseOffer {
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
      'date_time': dateTime.toString(),
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

  @override
  String toJson() => json.encode(toMap());

  factory RemoveOfferRequest.fromJson(String source) =>
      RemoveOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
