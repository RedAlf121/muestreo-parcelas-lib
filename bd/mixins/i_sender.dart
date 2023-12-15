

import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/bd/mixins/i_send_data.dart';

abstract class ISender extends ISendData{
  Future<void> sendPlantData({
    required int idParcel, 
    required int idPolyonal, 
    required LatLng pos, 
    Map<String,double>? values, 
    String? specieName, 
    String? commen, 
    int? idPlant
  });
  Future<void> sendGroundData({
    required int idMessage,  
    required int idParcel, 
    required int idPolygonal, 
    Map<String,dynamic>? values, 
    String? commen
  });
}
