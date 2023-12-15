

import 'package:postgres/postgres.dart';

abstract class ISendData{
  Future<PostgreSQLResult> displayData(int idMessage,int idUser);
}