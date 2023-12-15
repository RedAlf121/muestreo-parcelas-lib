import '../../logic/user.dart';
import '../mixins/crud.dart';

import '../general_query.dart';

class UserDAO extends GeneralQuery with Crud<User> {
  
  User? _userInstance;  

  UserDAO(this._userInstance);
  // Setter
  set userInstance(User value) {
    _userInstance = value;
  }

  @override
  Future<User> delete(String query, bool isQuery, int index) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<User> read(String query, bool isQuery, int index) {
    // TODO: implement read
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(String query, bool isQuery, int index, User parameter) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<void> insert(String query, bool isQuery) {
    // TODO: implement insert
    throw UnimplementedError();
  }
}
