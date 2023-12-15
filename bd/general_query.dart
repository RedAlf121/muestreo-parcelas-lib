import 'dart:convert';

import 'package:muestreo_parcelas/utils/config.dart';
import 'package:postgres/postgres.dart';

final conn = PostgreSQLConnection(
  get('ip'),
  int.parse(get('port')),
  get('database'),
  username: get('user'),
  password: utf8.decode(get('password').split(',').map(int.parse).toList())
);

abstract class GeneralQuery {
  
  Future<dynamic> execute<PostgreSQLResult>({
    required String query, 
    bool isQuery = false
  }) async {

    final result;
    if (isQuery) {
      result = await conn.query(query);
    } else {
      result = await conn.execute(query);
    }
    return result;
  }
}
