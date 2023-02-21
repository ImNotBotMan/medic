import 'package:server/dto/company/company.dart';
import 'package:server/repos/data_source.dart';

class CompanyRepo {
  final MySqlDataSource db;

  CompanyRepo(this.db);

  Future<List<Company>> getCompanies() async {
    final companies = <Company>[];
    final dbString = await db.read('select * from companies', null);
    for (var e in dbString.rows) {
      companies.add(Company.fromMap(e.assoc()));
    }
    return companies;
  }
}
