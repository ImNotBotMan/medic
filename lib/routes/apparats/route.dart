import 'dart:convert';
import 'dart:io';

import 'package:server/dto/apparat/apparat.dart';
import 'package:server/repos/apparats_repo.dart';
import 'package:server/repos/user_repo.dart';

class ApparatRoute {
  final ApparatsRepo repo;
  final UserRepo userRepo;
  static const String route = 'apparats';

  ApparatRoute(this.repo, this.userRepo);
  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'PUT':
        if (request.uri.pathSegments.contains('check')) {
          String content = await utf8.decodeStream(request);
          await repo.makeCheckApparat(json.decode(content)['id']);
          resp = 'Выполнено';
          break;
        } else {
          String content = await utf8.decodeStream(request);
          await repo.removeApparat(json.decode(content)['id']);
          resp = 'Выполнено';
          break;
        }
      case 'GET':
        if (request.uri.pathSegments.contains('details')) {
          String content = await utf8.decodeStream(request);
          final data = await repo.getApparatById(json.decode(content)['id']);
          final user = await userRepo.getUserById(json.decode(content)['user_id']);
          if (user == null) {
            throw 'No user';
          }
          resp = ApparatDetails(apparat: data, user: user).toJson();
        } else {
          String content = await utf8.decodeStream(request);
          final data = await repo.getUsersApparats(json.decode(content)['user_id']);
          resp = data.map((e) => e.toJson()).toList().toString();
        }
        break;
      default:
    }
    return resp;
  }
}
