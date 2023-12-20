import 'package:postgres/src/execution_context.dart';

import '../mixins/i_verifier.dart';
import 'dao_user.dart';

class AdminDAO extends UserDAO implements IVerifier {
  AdminDAO(super.userInstance);

  @override
  Future<void> acceptGroundData(int idMessage) async {
    Map<String, dynamic> map = {
      'idMessage': idMessage,
    };
    await execute(
        query: 'SELECT FROM func_accept_message_ground_data(@idMessage)',
        parameters: map);
  }

  @override
  Future<void> acceptPlantData(
      {required int idPlant,
      required int idParcel,
      required int idPolygonal,
      required int idMessage}) async {
    Map<String, dynamic> map = {
      'id_plant': idPlant,
      'id_parcel': idParcel,
      'id_polygonal': idPolygonal,
      'id_message': idMessage
    };
    await execute(
        query:
            'SELECT FROM func_accept_message_plant_data(@id_plant, @id_parcel, @id_polygonal, @id_message)',
        parameters: map);
  }

  @override
  Future<void> rejectData(int idMessage) async {
    Map<String, dynamic> map = {
      'id_message': idMessage
    };
    await execute(
        query:
            'SELECT FROM func_reject_message(@id_message)',
        parameters: map);
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
    await rejectData(message);
  }
  
  @override
  Future<void> deleteAllData(List<int> messages) async {
      await execute(
      query: 'SELECT * FROM func_reject_all_message(@messages)',
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

  Future<void> updateAllGround({required int idPlant, required int idSample, required int idPolygonal,required List<int> messages}) async {
    await execute(
      query: 'SELECT FROM func_update_all_data_plant(@id_plan, @id_samp, @id_pol, @messages)'

    );
  }

  Future<void> updateAllPlants(List<int> messages) async {
    await execute(
      query: 'SELECT FROM func_update_all_ground_data(@messages)'

    );
  }
  
  
}
