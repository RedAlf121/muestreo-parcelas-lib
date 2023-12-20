import 'dart:convert';

import 'package:muestreo_parcelas/utils/config.dart';
import 'package:postgres/postgres.dart';
//prueba momentanea xq coger los datos de un json no funciona correctamente


abstract class GeneralQuery {
  Future<Map<String,dynamic>> execute<PostgreSQLResult>(
      {required String query,
      bool isQuery = true,
      Map<String, dynamic>? parameters}) async {
    Map<String,dynamic> mapResult = {};
    final conn = PostgreSQLConnection(
    '152.206.175.49',5432,'MuestreoParcelas',
    username: 'postgres',
    password: 'pi3141592653589793'
    );
    await conn.open();
    if (isQuery) {
      final result = await conn.query(query, substitutionValues: parameters);//obtenemos la query
      // ignore: avoid_function_literals_in_foreach_calls
      result.forEach((element) => mapResult.addAll(element.toColumnMap()));//convertimos a mapa        
    } else {
      await conn.execute(query, substitutionValues: parameters);
    }
    await conn.close();
    return mapResult;
  }
}
