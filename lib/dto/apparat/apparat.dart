// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:server/dto/user/user.dart';

class ApparatDetails {
  final Apparat apparat;
  final User user;

  ApparatDetails({
    required this.apparat,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apparat': apparat.toMap(),
      'user': user.toMap(),
    };
  }

  factory ApparatDetails.fromMap(Map<String, dynamic> map) {
    return ApparatDetails(
      apparat: Apparat.fromMap(map['apparat'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApparatDetails.fromJson(String source) => ApparatDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Apparat {
  final String id;
  final String description;
  final String serviceStatus;
  final String isActive;

  Apparat({
    required this.id,
    required this.description,
    required this.serviceStatus,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'serviceStatus': serviceStatus,
      'isActive': isActive,
    };
  }

  factory Apparat.fromMap(Map<String, dynamic> map) {
    return Apparat(
      id: map['id'] as String,
      description: map['description'] as String,
      serviceStatus: map['service_status'] as String,
      isActive: map['isActive'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Apparat.fromJson(String source) => Apparat.fromMap(json.decode(source) as Map<String, dynamic>);
}
