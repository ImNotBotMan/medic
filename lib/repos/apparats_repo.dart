import 'package:server/dto/apparat/apparat.dart';
import 'package:server/repos/data_source.dart';

class ApparatsRepo {
  final MySqlDataSource db;

  ApparatsRepo(this.db);

  Future<void> makeCheckApparat(String id) async {
    await db.write(
      'update apparats set service_status=1 where id=:id',
      {"id": id},
    );
  }

  Future<void> removeApparat(String id) async {
    await db.write(
      'update apparats set isActive=0 where id=:id',
      {"id": id},
    );
  }

  Future<List<Apparat>> getUsersApparats(String userId) async {
    List<Apparat> items = [];
    final data = await db.read(
      'select * from apparats where user_id=:user_id',
      {'user_id': userId},
    );
    for (var e in data.rows) {
      items.add(Apparat.fromMap(e.assoc()));
    }
    return items;
  }

  Future<List<Apparat>> getAllApparats() async {
    List<Apparat> items = [];
    final data = await db.read('select * from apparats', {});
    for (var e in data.rows) {
      items.add(Apparat.fromMap(e.assoc()));
    }
    return items;
  }

  Future<Apparat> getApparatById(String id) async {
    final data = await db.read(
      'select * from apparats where id=:id',
      {'id': id},
    );
    return Apparat.fromMap(data.rows.first.assoc());
  }
}
