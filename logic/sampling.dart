import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_admin.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_observer.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_parcel.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_polygonal.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_sampling.dart';
import 'package:muestreo_parcelas/bd/general_query.dart';
import 'package:muestreo_parcelas/bd/mixins/crud.dart';
import 'package:muestreo_parcelas/bd/mixins/i_sender.dart';
import 'package:muestreo_parcelas/bd/mixins/polygonal_report.dart';
import 'package:muestreo_parcelas/bd/mixins/sampling_reports.dart';
import 'package:muestreo_parcelas/logic/admin.dart';
import 'package:muestreo_parcelas/logic/observer.dart';
import 'package:muestreo_parcelas/logic/polygonal.dart';
import 'package:muestreo_parcelas/logic/user.dart';
import '../bd/mixins/parcel_report.dart';
import '../bd/mixins/send_data.dart';
import '../bd/mixins/user_report.dart';
import 'parcel.dart';

typedef Output = Map<String,dynamic>;
final singletonSampling = _Sampling();
class _Sampling extends GeneralQuery {
  late User actualUser;
  List<Polygonal> polygons = [];
  _Sampling();

  int? id = 0;
  String? userName = '';
  String? firstName = '';
  String? lastName = '';
  String? password = '';

  Future<void> signInUser({required String firstName,required String lastName,required String userName,required String password,isAdmin = false}) async {
    // Crea una nueva instancia de UserAdmin o UserObserver
    User user = isAdmin? UserAdmin(userName: userName,firstName: firstName,lastName: lastName,password: encryptPassword(password) ) : UserObserver(userName: userName,firstName: firstName,lastName: lastName,password: encryptPassword(password));
    IUserReport userDataBAccess =
        (isAdmin) ? AdminDAO(user) : ObserverDAO(user);
    await userDataBAccess.signInUser();
  }

  Future<void> loginUser(String userName, String password) async {
    // Establece el nombre de usuario y la contraseña del usuario actual
    IUserReport userDataBAccess =
        AdminDAO(UserAdmin(userName: userName, password: encryptPassword(password)));
    // Intenta iniciar sesión
    actualUser = await userDataBAccess.loginUser();
    print(actualUser);
  }

  String encryptPassword(String password) => sha256.convert(utf8.encode(password)).toString();
  
  Future<void> updateUserData({String? firstName,String? lastName,String? userName,String? password}) async {
    User provisional;
    Crud<User> userData;
    if (actualUser is UserAdmin) {
      provisional = UserAdmin();
      userData = AdminDAO(actualUser);
    } else {
      provisional = UserObserver();
      userData = ObserverDAO(actualUser);
    }
    if (firstName != null) {provisional.firstName = firstName;}
    if (lastName != null) {provisional.lastName = lastName;}
    if (userName != null) {provisional.userName = userName;}
    if (password != null) {provisional.password = password;}

    actualUser = await userData.update(provisional);
  }

  Output showUserData() {
    return {
      'id': actualUser.id,
      'firstName': actualUser.firstName,
      'lastName': actualUser.lastName,
      'userName': actualUser.userName,
      'password': actualUser.password
    };
  }

  Future<Output> displayUserMessage() async {
    //mostrar los mensajes a revisar de un administrador o los mensajes enviados de un observador
    Map<String, dynamic> result;
    SendData? sended;
    getUser(sended);

    //este displayData va a mostrar las parcelas en las que se ha modificado algo
    //por ejemplo si es administrador va a mostrar las parcelas a las que esta a cargo
    //si es observador va a mostrar las parcelas en las que ha modificado algo
    result = await sended!.displayData();
    return result;
  }  

  void deleteMessage(int message){
    SendData? userData;
    getUser(userData);
    userData!.deleteMessage(message);
  }

  Future<Output> displayPlantData() async {
    
    SendData? userData;
    getUser(userData);
    Output result = await userData!.displayPlantsData();
    return result;
  }

  Future<Output> displayGroundData() async {
    
    SendData? userData;
    getUser(userData);
    Output result = await userData!.displayGroundData();
    return result;
  }

  Future<Output> displayPlantMessages() async {
    
    SendData? userData;
    getUser(userData);
    Output result = await userData!.displayPlantMessages();
    return result;
  }

  Future<Output> displayGroundMessages() async {
    
    SendData? userData;
    getUser(userData);
    Output result = await userData!.displayGroundMessages();
    return result;
  }

  Future<void> deleteAllData(List<int> messages) async {
    SendData? userData;
    getUser(userData);
    await userData!.deleteAllData(messages);
  }



  void getUser(userData) {
    if(actualUser is UserAdmin){
      userData = AdminDAO(actualUser);
    }else{
      userData = ObserverDAO(actualUser);
    }
  }

  Future<void> updateAllGroundData({required List<int> messages}) async {//true ground, false planta
    if(actualUser is UserAdmin){
      AdminDAO userData = AdminDAO(actualUser);
      await userData.updateAllPlants(messages);
    }
  }

  Future<void> updateAllPlantData({required int idPlant, required int idSample, required int idPolygonal,required List<int> messages}) async {//true ground, false planta
    if(actualUser is UserAdmin){
      AdminDAO userData = AdminDAO(actualUser);
      await userData.updateAllGround(
        idPlant: idPlant, 
        idSample: idSample, 
        idPolygonal: idPolygonal,
        messages: messages
      );
    }    
  }
 
  //TODO ir haciendo los reportes que hagan falta

  //propiedades del suelo
  Future<void> editParcel({
    required int idParcel,    
    required int idPolygonal,
    required int idMessage,
    required Map<String,dynamic> values,
  }) async {
    if(actualUser is UserObserver){
      ISender userData = ObserverDAO(actualUser);
      await userData.sendGroundData(
        idParcel: idParcel,
        idPolygonal: idPolygonal,
        idMessage: idMessage,
        values: values,
      );
    }
  }

  Future<void> editPolygon({required int id,required String region}) async {
    Polygonal selectedPolygon = polygons.firstWhere((element) => element.getId()==id);
    Crud<Polygonal> polygonData = PolygonalDAO(selectedPolygon);
    await polygonData.update(Polygonal(region:region));
  }

  Future<void> editPlant({
    required int idSample, 
    required int idPolygonal, 
    required Map<String,double> values, 
    String? specieName,
    int? idPlant,
    LatLng? position
  }) async {
    if(actualUser is UserObserver){
      ISender userData = ObserverDAO(actualUser);
      await userData.sendPlantData(
        idParcel: idSample, 
        idPolyonal: idPolygonal,
        pos: position,
        idPlant: idPlant,
        specieName: specieName,
        values: values
      );
    }
  }

  Future<void> loadMap() async {
    Map<String,List> cache = {
      'polygonal' : [],//Lista normal
      'parcel' : [],//matriz NxM (poligonal x parcela)
      'plant' : []//matriz NxMxP (poligonal x parcela x planta)
    };
    //polygons es una lista de poligonales que tienen un id como atributo y una lista de parcels
    //parcels contiene el id de la clase que lo guarda, ademas tiene su propio id y una lista de plant
    //plant contiene el id de las dos clases mencionadas y su propio id

    //la idea es almacenar en la variable cache los indices en su respectiva llave para luego pasarlo por parametros a los metodos de abajo

    SamplingReports data = SamplingDAO();
    await data.allParcels();
    await data.allPolygonals();
    await data.allPlants;
    //por cada all habria que llenar las clases esas, poligonal tendria que almacenar por id las parcels y las parcels tienen que almacenar por id las parcelas con ese id de poligonal
    //ademas de ir insertando en la lista de polygons las poligonales
  }

  Future<void> showParcel({
    required int idParcel,    
    required int idPolygonal,
    required Map<String,dynamic> values,
  }) async {
    
  }

  Future<void> showPolygon({required int id,required String region}) async {
    
  }

  Future<void> showPlant({
    required int idSample, 
    required int idPolygonal, 
    required Map<String,double> values, 
    String? specieName,
    int? idPlant,
    LatLng? position
  }) async {

  }

  Future<Output> flowerInventory({
    required int idPolygonal, 
    required String stratusName}) async{
      
    Polygonal actual = polygons.firstWhere((element) => element.id == idPolygonal);
    IPolygonalReport polygonalData = PolygonalDAO(actual);
    return await polygonalData.flowerInventroy();
  }
  Future<Output> polygonalParcelPoints(int idPolygonal)async{
      Polygonal actual = polygons.firstWhere((element) => element.id == idPolygonal);
      IPolygonalReport polygonalData = PolygonalDAO(actual);
      return await polygonalData.parcelPoints();
  }
  Future<Output> treeDistance({required int idPolygonal , required int idParcel})async{
      Parcel actual = polygons.firstWhere((element) => element.id == idPolygonal).findParcel(idParcel);
      IParcelReport polygonalData = ParcelDAO(actual);
      return await polygonalData.treeDistance();
  }
  Future<Output> speciesCount({required int idPolygonal , required int idParcel})async{
      Parcel actual = polygons.firstWhere((element) => element.id == idPolygonal).findParcel(idParcel);
      IParcelReport polygonalData = ParcelDAO(actual);
      return await polygonalData.countByStatrum();
  }

}
