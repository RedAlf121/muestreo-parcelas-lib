
import 'package:postgres/postgres.dart';

abstract class User{
  int _id=0;
  String _userName = '';
  String _firstName = '';
  String _lastName = '';

  User(PostgreSQLResult result){
    id = result.first[0];
    userName = result.first[1];
    firstName = result.first[2];
    lastName = result.first[3];
  }

  // Getters
  int get id => _id;
  String get userName => _userName;
  String get firstName => _firstName;
  String get lastName => _lastName;

  // Setters
  set id(int value) {
    _id = value;
  }

  set userName(String value) {
    _userName = value;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }
}
