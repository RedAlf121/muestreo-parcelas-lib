import 'package:muestreo_parcelas/bd/mixins/user_report.dart';
import 'package:muestreo_parcelas/logic/admin.dart';
import 'package:muestreo_parcelas/logic/observer.dart';

import '../../logic/user.dart';
import '../mixins/crud.dart';

import '../general_query.dart';

//HECHO
class UserDAO extends GeneralQuery implements Crud<User>, IUserReport {
  @override
  User? instance;

  UserDAO(this.instance);
  // Setter
  set parcelInstance(User value) {
    instance = value;
  }

  @override
  Future<User> delete() async {
    Map<String, dynamic> map = {'user_name': instance!.userName};
    execute(
        query: 'SELECT FROM func_delete_user(@user_name)',
        parameters: map,
        isQuery: false);
    return instance!;
  }

  @override
  Future<User> read() async {
    Map<String, dynamic> map = {
      'id_user': instance!.id,
    };
    await _getAndAssign(
        query: 'SELECT * FROM func_read_user(@id_user)', map: map);
    return instance!;
  }

  Future<void> _getAndAssign(
      {required String query, Map<String, dynamic>? map}) async {
    final result = await execute(query: query, parameters: map);
    _asignNewValues(result);
  }

  @override
  Future<User> update(User parameter) async {
    Map<String, dynamic> map = {
      'id_user': instance!.id,
      'user_name': parameter.userName,
      'first_name': parameter.firstName,
      'last_name': parameter.lastName
    };
    await execute(
        query:
            'SELECT FROM func_update_user(@id_user, @user_name, @first_name, @last_name)',
        parameters: map);
    _asignNewValues(map);
    return instance!;
  }

  @override
  Future<User> insert() async {
    Map<String, dynamic> map = {
      'user_name': instance!.userName,
      'user_password': instance!.password,
      'first_name': instance!.firstName,
      'last_name': instance!.lastName
    };
    _getAndAssign(
        query:
            'SELECT * FROM func_create_user(@user_name, @user_password, @first_name, @last_name)',
        map: map);
    return instance!;
  }

  @override
  Future<User> loginUser() async {
    Map<String, dynamic> map = {
      'user_name': instance!.userName,
      'user_password': instance!.password,
    };
    Map<String, dynamic> result = await execute(
        query: 'SELECT * FROM func_get_user_data(@user_name,@user_password)',
        parameters: map);
    if(result.isEmpty) throw Exception('Ese usuario no existe');
    instance = (result['user_type'])
        ? UserAdmin(
            firstName: result['first_name'],
            lastName: result['last_name'],
            userName: result['user_name'],
            password: result['password'])
        : UserObserver(
            firstName: result['first_name'],
            lastName: result['last_name'],
            userName: result['user_name'],
            password: result['password']);

    return instance!;
  }

  @override
  Future<void> signInUser() async {
    try{
      await read();
    }catch(e){
      throw Exception('El usuario ya existe');
    };
  }

  void _asignNewValues(Map<String, dynamic> result) {
    instance!.firstName =
        result['first_name'] as String? ?? instance!.firstName;
    instance!.lastName = result['last_name'] as String? ?? instance!.lastName;
    instance!.userName = result['user_name'] as String? ?? instance!.userName;
    instance!.password = result['password'] as String? ?? instance!.password;
  }
}
