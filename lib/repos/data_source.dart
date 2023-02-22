import 'package:mysql_client/mysql_client.dart';

abstract class IDataSource {
  Future<void> init();

  Future<void> write(String query, Map<String, dynamic>? params);
  Future<IResultSet> read(String query, Map<String, dynamic>? params);
}

class MySqlDataSource implements IDataSource {
  late final MySQLConnection connection;

  @override
  Future<void> init() async {
    connection = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      secure:false,
      userName: 'user',
      password: 'password',
      databaseName: 'medic',
    );
    await connection.connect();
    print('CONNECTED_TO_MYSQL:${connection.connected}');
  }

  @override
  Future<IResultSet> read(String query, Map<String, dynamic>? params) async {
    final res = await connection.execute(query, params);
    return res;
  }

  @override
  Future<void> write(String query, Map<String, dynamic>? params) async {
    await connection.execute(query, params);
  }
}
