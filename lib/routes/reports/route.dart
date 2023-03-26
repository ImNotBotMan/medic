import 'dart:convert';
import 'dart:io';

import 'package:server/dto/apparat/apparat.dart';
import 'package:server/dto/company/company.dart';
import 'package:server/dto/offers/base_offer.dart';
import 'package:server/dto/offers/buy_offer.dart';
import 'package:server/dto/offers/remove_offer.dart';
import 'package:server/dto/offers/replace_offer.dart';
import 'package:server/dto/user/user.dart';
import 'package:server/repos/apparats_repo.dart';
import 'package:server/repos/company_repo.dart';
import 'package:server/repos/offer_repo.dart';
import 'package:server/repos/report_repo.dart';
import 'package:server/repos/user_repo.dart';

class ReportRoute {
  // final ReportRepo reportRepo;
  final OfferRepo offerRepo;
  final UserRepo userRepo;
  final CompanyRepo companyRepo;
  final ApparatsRepo apparatsRepo;

  static const String route = 'reports';

  ReportRoute({
    required this.offerRepo,
    required this.userRepo,
    required this.companyRepo,
    required this.apparatsRepo,
  });
  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'GET':
        String content = await utf8.decodeStream(request);
        final List<BaseReport> reports = [];
        if (request.uri.pathSegments.contains('admin')) {
          final res = await offerRepo.getAllOffers();
          for (var e in res) {
            if (e is ReplaceOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              final company = await getCompany(e.companyId);
              reports.add(ReplaceOfferReport(
                apparat: apparat,
                offer: e,
                user: user!,
                company: company!,
              ));
            }
            if (e is RemoveOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              reports.add(
                RemoveOfferReport(
                  offer: e,
                  user: user!,
                  apparat: apparat,
                ),
              );
            }
            if (e is BuyOfferRequest) {
              final user = await getUser(e.userId);
              reports.add(ButOfferReport(offer: e, user: user!));
            }
          }
          resp = reports.map((e) => e.toJson()).toList().toString();
        } else if (request.uri.pathSegments.contains('apparat')) {
          final String userId = json.decode(content)['id'];
          final String apparatId = json.decode(content)['apparat_id'];
          final List<BaseReport> reports = [];
          final res = await offerRepo.getApparatOffers(userId, apparatId);
          for (var e in res) {
            if (e is ReplaceOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              final company = await getCompany(e.companyId);
              reports.add(ReplaceOfferReport(
                apparat: apparat,
                offer: e,
                user: user!,
                company: company!,
              ));
            }
            if (e is RemoveOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              reports.add(
                RemoveOfferReport(
                  offer: e,
                  user: user!,
                  apparat: apparat,
                ),
              );
            }
            if (e is BuyOfferRequest) {
              final user = await getUser(e.userId);
              reports.add(ButOfferReport(offer: e, user: user!));
            }
          }
          resp = reports.map((e) => e.toJson()).toList().toString();
        } else {
          final String userId = json.decode(content)['id'];
          final res = await offerRepo.getOffers(userId);
          final List<BaseReport> reports = [];
          for (var e in res) {
            if (e is ReplaceOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              final company = await getCompany(e.companyId);
              reports.add(ReplaceOfferReport(
                apparat: apparat,
                offer: e,
                user: user!,
                company: company!,
              ));
            }
            if (e is RemoveOfferRequest) {
              final apparat = await getApparat(e.apparatId);
              final user = await getUser(e.userId);
              reports.add(
                RemoveOfferReport(
                  offer: e,
                  user: user!,
                  apparat: apparat,
                ),
              );
            }
            if (e is BuyOfferRequest) {
              final user = await getUser(e.userId);
              reports.add(ButOfferReport(offer: e, user: user!));
            }
          }

          resp = reports.map((e) => e.toJson()).toList().toString();
        }
        break;

      default:
    }
    return resp;
  }

  Future<Apparat> getApparat(id) async {
    return await apparatsRepo.getApparatById(id);
  }

  Future<User?> getUser(id) async {
    return await userRepo.getUserById(id);
  }

  Future<Company?> getCompany(id) async {
    return await companyRepo.getCompanyById(id);
  }
}
