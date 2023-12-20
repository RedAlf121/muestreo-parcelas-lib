import 'package:latlong2/latlong.dart';
import 'package:postgres/postgres.dart';
import '../mixins/i_sender.dart';
import 'dao_user.dart';

class ObserverDAO extends UserDAO implements ISender {
  ObserverDAO(super.userInstance);

  @override
  Future<void> sendGroundData(
      {required int idMessage,
      required int idParcel,
      required int idPolygonal,
      required Map<String, dynamic> values,
      String? commen}) async {
    Map<String, dynamic> map = {
      'idMessage': idMessage,
      'id_user': instance!.id,
      'idParcel': idParcel,
      'idPolygonal': idPolygonal,
      'atributes': values,
      'comment': commen,
    };
    await execute(
        query:
            'SELECT FROM func_send_observer_data_ground(@idMessage, @id_user, @idParcel, @idPolygonal, @values, @comment)',
        parameters: map,
        isQuery: false
    );
  }

  @override
  Future<void> sendPlantData(
      {
      required int idParcel,
      required int idPolyonal,
      LatLng? pos,
      Map<String, double>? values,
      String? specieName,
      String? commen,
      int? idPlant}) async {
    Map<String, dynamic> map = {
      'id_user': instance!.id,
      'id_parcel': idParcel,
      'id_pol': idPolyonal,
      'pos': pos,
      'values': values,
      'specie_name': specieName,
      'commen': commen,
      'id_plant': idPlant
    };
    await execute(
        query:
            'SELECT FROM func_send_observer_data_plant(@id_user, @id_parcel, @id_pol, @values.key, @values.values, @specie_name, @commen, @id_plant, @pos)',
        parameters: map,
        isQuery: false
    );
  }

  @override
  Future<Map<String,dynamic>> displayData() async {
    final result = await execute(
      query: 'SELECT * FROM func_display_observer_parcel_data(@user_id)',
      parameters: {
        'user_id' : instance!.id
      }
    );
    return result;
  }
  
  @override
  Future<void> deleteMessage(int message) async {
    Map<String,dynamic> result = await execute(
      query: 'SELECT * FROM func_delete_observer_messages(@id_message,@id_user)',
      parameters: {
        'id_message' : message,
        'id_user' : instance!.id
      }
    );
    if(!result.values.first)throw Exception('No se puede modificar el mensaje. Porque ya el administrador lo utlizó');
  }
  
  @override
  Future<void> deleteAllData(List<int> messages) async {
    await execute(
      query: 'SELECT * FROM func_delete_observer_all_messages(@messages)',
      parameters: {
        'messages' : messages,
      }

    );
  }
  
  @override
  Future<Map<String, dynamic>> displayGroundData() async {
    return await execute(
      query: '',
      parameters: {

      }
    );
  }
  
  @override
  Future<Map<String, dynamic>> displayPlantsData() async {
    return await execute(
      query: '',
      parameters: {

      }
    );
  }
  
  @override
  Future<Map<String, dynamic>> displayGroundMessages() async {
    return await execute(
      query: '',
      parameters: {

      }
    );
  }
  
  @override
  Future<Map<String, dynamic>> displayPlantMessages() async {
    return await execute(
      query: '',
      parameters: {

      }
    );
  }
}
