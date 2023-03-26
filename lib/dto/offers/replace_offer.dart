// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:server/dto/apparat/apparat.dart';
import 'package:server/dto/company/company.dart';
import 'package:server/dto/offers/base_offer.dart';
import 'package:server/dto/user/user.dart';

class ReplaceOfferReport implements BaseReport {
  final ReplaceOfferRequest offer;
  final User user;
  final Apparat apparat;
  final Company company;

  ReplaceOfferReport({
    required this.offer,
    required this.user,
    required this.apparat,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offer': offer.toMap(),
      'user': user.toMap(),
      'apparat': apparat.toMap(),
      'company': company.toMap(),
    };
  }

  factory ReplaceOfferReport.fromMap(Map<String, dynamic> map) {
    return ReplaceOfferReport(
      offer: ReplaceOfferRequest.fromMap(map['offer'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      apparat: Apparat.fromMap(map['apparat'] as Map<String, dynamic>),
      company: Company.fromMap(map['company'] as Map<String, dynamic>),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ReplaceOfferReport.fromJson(String source) =>
      ReplaceOfferReport.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReplaceOfferRequest implements BaseOffer {
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
      'date_time': dateTime.toString(),
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

  @override
  String toJson() => json.encode(toMap());

  factory ReplaceOfferRequest.fromJson(String source) =>
      ReplaceOfferRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
