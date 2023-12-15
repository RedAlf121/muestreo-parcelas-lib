import 'package:latlong2/latlong.dart';
import 'package:postgres/postgres.dart';
import '../mixins/i_sender.dart';
import 'dao_user.dart';

class ObserverDAO extends UserDAO implements ISender {
  ObserverDAO(super.userInstance);


  @override
  Future<void> sendGroundData({
    required int idMessage, 
    required int idParcel, 
    required int idPolygonal, 
    Map<String, dynamic>? values, 
    String? commen}
  ) {
    // TODO: implement sendGroundData
    throw UnimplementedError();
  }

  @override
  Future<void> sendPlantData({required int idParcel, required int idPolyonal, required LatLng pos, Map<String, double>? values, String? specieName, String? commen, int? idPlant}) {
    // TODO: implement sendPlantData
    throw UnimplementedError();
  }

  @override
  Future<PostgreSQLResult> displayData(int idMessage, int idUser) {
    // TODO: implement displayData
    throw UnimplementedError();
  }

  
}