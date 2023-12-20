import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/bd/mixins/send_data.dart';

abstract class ISender extends SendData{
  Future<void> sendPlantData({
      required int idParcel,
      required int idPolyonal,
      LatLng? pos,
      Map<String, double>? values,
      String? specieName,
      String? commen,
      int? idPlant});
  Future<void> sendGroundData(
      {required int idMessage,
      required int idParcel,
      required int idPolygonal,
      required Map<String, dynamic> values,
      String? commen});

  
}
