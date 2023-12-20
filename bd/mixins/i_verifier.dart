
import 'package:muestreo_parcelas/bd/mixins/send_data.dart';

abstract class IVerifier extends SendData{
  Future<void> acceptPlantData(
      {required int idPlant,
      required int idParcel,
      required int idPolygonal,
      required int idMessage});

  Future<void> acceptGroundData(int idMessage);

  Future<void> rejectData(int idMessage);    

}
