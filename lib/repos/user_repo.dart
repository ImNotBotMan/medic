import 'package:server/dto/user/user_request.dart';
import 'package:server/repos/data_source.dart';

import '../dto/user/user.dart';

class UserRepo {
  final MySqlDataSource db;

  UserRepo(this.db);

  Future<String> addUser(UserRequest userRequest) async {
    final isExist = await _isExistsUser(userRequest);
    if (!isExist) {
      await db.write(
        'insert into users (phone, password, role) values (:phone, :password, :role)',
        userRequest.toMap(),
      );
      return 'Пользователь создан';
    } else {
      return 'Пользователь с таким e-mail уже существует';
    }
  }

  Future<bool> _isExistsUser(UserRequest userRequest) async {
    final res = await db.read('select count(*) from users where phone=:phone', userRequest.toMap());
    final count = int.parse(res.rows.first.assoc().values.first ?? '0');
    return count != 0;
  }

  Future<User?> getUserById(String userId) async {
    final res = await db.read('select * from users where id=:id', {'id': userId});

    return User.fromMap(res.rows.first.assoc());
  }

  Future<User?> getUser(UserRequest userRequest) async {
    final isExists = await _isExistsUser(userRequest);
    if (isExists) {
      final res = await db.read('select * from users where phone=:phone and password=:password;', userRequest.toMap());

      return User.fromMap(res.rows.first.assoc());
    } else {
      return null;
    }
  }
}
