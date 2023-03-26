import 'package:server/dto/offers/base_offer.dart';
import 'package:server/dto/offers/buy_offer.dart';
import 'package:server/dto/offers/remove_offer.dart';
import 'package:server/dto/offers/replace_offer.dart';
import 'package:server/repos/data_source.dart';

class OfferRepo {
  final MySqlDataSource db;

  OfferRepo(this.db);

  Future<void> makeReplaceOffer(ReplaceOfferRequest request) async {
    await db.write(
      '''
      insert into offers_replace 
      (
        user_id,
        offer_type_id,
        apparat_id,
        description,
        company_id,
        date_time
      ) values (
          :user_id,
          :offer_type_id,
          :apparat_id,
          :description,
          :company_id,
          :date_time
      ) ''',
      request.toMap(),
    );
  }

  Future<void> makeBuyOffer(BuyOfferRequest request) async {
    await db.write(
      '''
      insert into offers_buy 
      (
        user_id,
        offer_type_id,
        additional_offer_data,
        date_time
      ) values (
          :user_id,
          :offer_type_id,
          :additional_offer_data,
          :date_time
      ) ''',
      request.toMap(),
    );
  }

  Future<void> makeRemoveOffer(RemoveOfferRequest request) async {
    await db.write(
      '''
      insert into offers_remove 
      (
        user_id,
        offer_type_id,
        apparat_id,
        date_time
      ) values (
          :user_id,
          :offer_type_id,
          :apparat_id,
          :date_time
      ) ''',
      request.toMap(),
    );
  }

  Future<List<BaseOffer>> getApparatOffers(String userID, String apparatId) async {
    final List<BaseOffer> offers = [];
    final dbRemove = await db.read("select * from offers_remove where user_id=:user_id and apparat_id=:apparat_id", {
      'user_id': userID,
      "apparat_id": apparatId,
    });
    for (var e in dbRemove.rows) {
      offers.add(RemoveOfferRequest.fromMap(e.assoc()));
    }

    final dbReplace = await db.read("select * from offers_replace where user_id=:user_id and apparat_id=:apparat_id ", {
      'user_id': userID,
      "apparat_id": apparatId,
    });
    for (var e in dbReplace.rows) {
      offers.add(ReplaceOfferRequest.fromMap(e.assoc()));
    }
    return offers;
  }

  Future<List<BaseOffer>> getOffers(String userID) async {
    final List<BaseOffer> offers = [];
    final dbRemove = await db.read("select * from offers_remove where user_id=:user_id", {
      'user_id': userID,
    });
    for (var e in dbRemove.rows) {
      offers.add(RemoveOfferRequest.fromMap(e.assoc()));
    }
    final dbbuy = await db.read("select * from offers_buy where user_id=:user_id", {
      'user_id': userID,
    });
    for (var e in dbbuy.rows) {
      offers.add(BuyOfferRequest.fromMap(e.assoc()));
    }
    final dbReplace = await db.read("select * from offers_replace where user_id=:user_id", {
      'user_id': userID,
    });
    for (var e in dbReplace.rows) {
      offers.add(ReplaceOfferRequest.fromMap(e.assoc()));
    }
    return offers;
  }

  Future<List<BaseOffer>> getAllOffers() async {
    final List<BaseOffer> offers = [];
    final dbRemove = await db.read("select * from offers_remove", {});
    for (var e in dbRemove.rows) {
      offers.add(RemoveOfferRequest.fromMap(e.assoc()));
    }
    final dbbuy = await db.read("select * from offers_buy", {});
    for (var e in dbbuy.rows) {
      offers.add(BuyOfferRequest.fromMap(e.assoc()));
    }
    final dbReplace = await db.read("select * from offers_replace", {});
    for (var e in dbReplace.rows) {
      offers.add(ReplaceOfferRequest.fromMap(e.assoc()));
    }
    return offers;
  }
}
