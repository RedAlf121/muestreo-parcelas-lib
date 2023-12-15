
import 'package:muestreo_parcelas/bd/DAO/dao_admin.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_observer.dart';
import 'package:muestreo_parcelas/bd/DAO/dao_sampling.dart';
import 'package:muestreo_parcelas/bd/mixins/i_report.dart';
import 'package:muestreo_parcelas/bd/mixins/i_send_data.dart';
import 'package:muestreo_parcelas/logic/admin.dart';
import 'package:muestreo_parcelas/logic/observer.dart';
import 'package:muestreo_parcelas/logic/user.dart';
import 'package:postgres/postgres.dart';

final singletonSampling = _Sampling();

class _Sampling {
  late IReport _databaseAccess;
  late User actualUser; 
  _Sampling() {
    _databaseAccess = SamplingDAO();
  }

  Future<void> signInUser(List<String> fields, {isAdmin = false}) async {
    if(fields.isEmpty) throw Exception('Error hay campos vacíos');
    await _databaseAccess.signInUser(fields,isAdmin);
  }

  Future<void> loginUser(String userName, String password) async {
    final PostgreSQLResult userData = await _databaseAccess.loginUser(userName: userName, password: password);
    if(userData.isEmpty) throw Exception('Ese usuario no existe, intente registrarse');
    
    //en dependencia de si el resultado de la tabla dice q es administrador o no
    //se crea un administrador o un observador
    actualUser = (userData.first.last)? UserAdmin(userData) : UserObserver(userData);    
  }

  Future<PostgreSQLResult> displayUserMessage(int idMessage) async {
    //mostrar los mensajes a revisar de un administrador o los mensajes enviados de un observador
    PostgreSQLResult res;
    ISendData sended;
    if(actualUser is UserAdmin){
        sended = AdminDAO(actualUser);
    }else{
        sended = ObserverDAO(actualUser);
    }
    //este displayData va a mostrar las parcelas en las que se ha modificado algo
    //por ejemplo si es administrador va a mostrar las parcelas a las que esta a cargo
    //si es observador va a mostrar las parcelas en las que ha modificado algo
    res = await sended.displayData(idMessage, actualUser.id);
    return res;
  }

  //TODO hacer un metodo que dado el usuario y la parcela muestre las plantas que ha modificado 
  //o si es administrador todas las plantas de esa parcela

  Future<void> deleteMessage(int idMessage) async{
    //TODO eliminar un mensaje seleccionado

  }



  //TODO ir haciendo los reportes que hagan falta 
  //e ir llamando metodos de IReport que es quien tiene el acceso a la base de datos

}