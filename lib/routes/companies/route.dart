import 'dart:io';

import 'package:server/repos/company_repo.dart';

class CompaniesRoute {
  final CompanyRepo repo;
  static const String route = 'companies';

  CompaniesRoute(this.repo);
  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'GET':
        final res = await repo.getCompanies();
        resp = res.map((e) => e.toJson()).toList().toString();
        break;

      default:
    }
    return resp;
  }
}
