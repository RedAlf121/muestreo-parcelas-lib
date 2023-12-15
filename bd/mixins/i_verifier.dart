

import 'package:muestreo_parcelas/bd/mixins/i_send_data.dart';

abstract class IVerifier extends ISendData{
  Future<void> acceptPlantData({
    required int idPlant, 
    required int idParcel, 
    required int idPolygonal,
    required int idMessage
  });
  Future<void> acceptGroundData(int idMessage);
  Future<void> rejectPlantData(int idMessage);
  Future<void> rejectGroundData(int idMessage);
}
