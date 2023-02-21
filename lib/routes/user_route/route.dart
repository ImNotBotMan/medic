import 'dart:convert';
import 'dart:io';

import 'package:server/dto/user/user_request.dart';
import 'package:server/repos/user_repo.dart';

class UserRoute {
  final UserRepo repo;
  static const String route = 'users';

  UserRoute(this.repo);

  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'GET':
        String content = await utf8.decodeStream(request);
        final res = await repo.getUser(UserRequest.fromJson(content));
        if (res == null) {
          resp = 'Пользователь не найден';
        } else {
          resp = res.toJson();
        }

        break;
      case 'POST':
        String content = await utf8.decodeStream(request);
        final res = await repo.addUser(UserRequest.fromJson(content));
        resp = res;
        break;
      default:
    }
    return resp;
  }
}
