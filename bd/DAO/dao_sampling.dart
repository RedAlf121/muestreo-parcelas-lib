import 'package:postgres/src/execution_context.dart';

import '../mixins/i_report.dart';
import '../general_query.dart';

class SamplingDAO extends GeneralQuery with IReport {
  
  

  @override
  Future<PostgreSQLResult> treeDistance(int polygonalIndex, int parcelIndex) async {
    // TODO: implement treeDistance
    throw UnimplementedError();
  }
  
  @override
  Future<PostgreSQLResult> countByStatrum(int polygonalIndex, String stratum) async {
    // TODO: implement countByStatrum
    throw UnimplementedError();
  }
  
  @override
  Future<PostgreSQLResult> flowerInventroy(int polygonalIndex, String stratum) async {
    // TODO: implement flowerInventroy
    throw UnimplementedError();
  }
  
  @override
  Future<PostgreSQLResult> loginUser({required String userName, required String password}) async {
    // TODO: implement loginUser
    throw UnimplementedError();
  }
  
  @override
  Future<PostgreSQLResult> parcelPoints(int polygonalIndex) async {
    // TODO: implement parcelPoints
    throw UnimplementedError();
  }
  
  @override
  Future<void> signInUser(List<String> fields, bool isAdmin) {
    // TODO: implement signInUser
    throw UnimplementedError();
  }
}
