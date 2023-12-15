import 'package:postgres/src/execution_context.dart';

import '../mixins/i_verifier.dart';
import 'dao_user.dart';

class AdminDAO extends UserDAO implements IVerifier {
  AdminDAO(super.userInstance);


  @override
  Future<void> acceptGroundData(int idMessage) {
    // TODO: implement acceptGroundData
    throw UnimplementedError();
  }
  
  @override
  Future<void> acceptPlantData({required int idPlant, required int idParcel, required int idPolygonal, required int idMessage}) {
    // TODO: implement acceptPlantData
    throw UnimplementedError();
  }
  
  @override
  Future<void> rejectGroundData(int idMessage) {
    // TODO: implement rejectGroundData
    throw UnimplementedError();
  }
  
  @override
  Future<void> rejectPlantData(int idMessage) {
    // TODO: implement rejectPlantData
    throw UnimplementedError();
  }

  @override
  Future<PostgreSQLResult> displayData(int idMessage, int idUser) {
    // TODO: implement displayData
    throw UnimplementedError();
  }
}
