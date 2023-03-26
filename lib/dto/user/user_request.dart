// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRequest {
  final String phone;
  final String password;
  final String? role;

  UserRequest({
    required this.phone,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'phone': phone, 'password': password, 'role': role??''};
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      phone: map['phone'] as String,
      password: map['password'] as String,
      role: map['role'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) => UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
