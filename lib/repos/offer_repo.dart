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
}
