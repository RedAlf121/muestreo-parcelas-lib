
import 'package:postgres/postgres.dart';

mixin IReport {
  Future<PostgreSQLResult> countByStatrum(int polygonalIndex, String stratum);
  Future<PostgreSQLResult> flowerInventroy(int polygonalIndex, String stratum);
  Future<PostgreSQLResult> parcelPoints(int polygonalIndex);
  Future<PostgreSQLResult> treeDistance(int polygonalIndex, int parcelIndex);
  Future<PostgreSQLResult> loginUser({required String userName, required String password});
  Future<void> signInUser(List<String> fields, bool isAdmin);
}
