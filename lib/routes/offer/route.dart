import 'dart:convert';
import 'dart:io';

import 'package:server/dto/offers/buy_offer.dart';
import 'package:server/dto/offers/remove_offer.dart';
import 'package:server/dto/offers/replace_offer.dart';
import 'package:server/repos/apparats_repo.dart';
import 'package:server/repos/company_repo.dart';
import 'package:server/repos/offer_repo.dart';
import 'package:server/repos/user_repo.dart';

class OfferRouteBuy {
  static const String route = 'buy';
  final OfferRepo repo;

  OfferRouteBuy(this.repo);

  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'PUT':
        String content = await utf8.decodeStream(request);
        await repo.makeBuyOffer(BuyOfferRequest.fromJson(content));
        resp = 'Заявка создана';
        break;
      default:
    }

    return resp;
  }
}

class OfferRouteReplace {
  static const String route = 'replace';
  final OfferRepo repo;
  final UserRepo userRepo;
  final CompanyRepo companyRepo;
  final ApparatsRepo apparatsRepo;

  OfferRouteReplace({
    required this.repo,
    required this.userRepo,
    required this.companyRepo,
    required this.apparatsRepo,
  });

  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'PUT':
        String content = await utf8.decodeStream(request);
        final offer = ReplaceOfferRequest.fromJson(content);
        await repo.makeReplaceOffer(offer);

        resp = 'Заявка создана';
        break;
      default:
    }

    return resp;
  }
}

class OfferRouteRemove {
  static const String route = 'remove';
  final OfferRepo repo;

  OfferRouteRemove(this.repo);

  Future<String> onRoute(HttpRequest request) async {
    late final String resp;
    switch (request.method) {
      case 'PUT':
        String content = await utf8.decodeStream(request);
        await repo.makeRemoveOffer(RemoveOfferRequest.fromJson(content));
        resp = 'Заявка создана';
        break;
      default:
    }

    return resp;
  }
}
