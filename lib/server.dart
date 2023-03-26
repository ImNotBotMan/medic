import 'dart:async';
import 'dart:io';

import 'package:server/repos/apparats_repo.dart';
import 'package:server/repos/company_repo.dart';
import 'package:server/repos/data_source.dart';
import 'package:server/repos/offer_repo.dart';
import 'package:server/repos/user_repo.dart';
import 'package:server/routes/apparats/route.dart';
import 'package:server/routes/companies/route.dart';
import 'package:server/routes/offer/route.dart';
import 'package:server/routes/reports/route.dart';
import 'package:server/routes/user_route/route.dart';
import 'package:server/utils/logger.dart';

void main() async {
  runZonedGuarded(
    () async {
      var server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
      final db = MySqlDataSource();
      await db.init();

      final userRepo = UserRepo(db);

      final offerRepo = OfferRepo(db);

      final userRoute = UserRoute(UserRepo(db));

      final ApparatsRepo apparatsRepo = ApparatsRepo(db);

      final apparatRoute = ApparatRoute(apparatsRepo, userRepo);
      final companyRepo = CompanyRepo(db);

      final companiesRoute = CompaniesRoute(companyRepo);

      final buyOffer = OfferRouteBuy(offerRepo);
      final replaceOffer = OfferRouteReplace(
        repo: offerRepo,
        userRepo: userRepo,
        apparatsRepo: apparatsRepo,
        companyRepo: companyRepo,
      );
      final removeOffer = OfferRouteRemove(offerRepo);

      final reportRoute =
          ReportRoute(offerRepo: offerRepo, userRepo: userRepo, companyRepo: companyRepo, apparatsRepo: apparatsRepo);
      await for (var request in server) {
        try {
          List<String> segments = request.uri.pathSegments;
          if (segments.isNotEmpty) {
            late String res;

            if (segments.contains('offer')) {
              switch (segments.last) {
                case OfferRouteBuy.route:
                  res = await buyOffer.onRoute(request);
                  break;
                case OfferRouteReplace.route:
                  res = await replaceOffer.onRoute(request);
                  break;
                case OfferRouteRemove.route:
                  res = await removeOffer.onRoute(request);
                  break;
                default:
              }
            } else {
              switch (segments.last) {
                case CompaniesRoute.route:
                  res = await companiesRoute.onRoute(request);
                  break;
                case UserRoute.route:
                  res = await userRoute.onRoute(request);
                  break;
                case ApparatRoute.route:
                  res = await apparatRoute.onRoute(request);
                  break;
                case ReportRoute.route:
                  res = await reportRoute.onRoute(request);
                  break;
                default:
              }
            }
            request.response
              ..statusCode = 200
              ..write(res)
              ..close();
          } else {
            request.response
              ..statusCode = 404
              ..write('error: no route')
              ..close();
          }
        } catch (e) {
          if (e is Error) {
            print(e.stackTrace);
          }
          if (e is FormatException) {
            print(e.source);
          }

          print(e.runtimeType);
          AppLog.verbose(e);
          request.response
            ..statusCode = 500
            ..write(e.toString())
            ..close();
        }
      }
    },
    (error, stack) {
      print(stack);
    },
  );
}
