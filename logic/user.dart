import 'package:postgres/postgres.dart';

abstract class User {
  int? id = 0;
  String? userName = '';
  String? firstName = '';
  String? lastName = '';
  String? password = '';

  User({this.userName,this.firstName, this.id,this.lastName,this.password});



  // Setters
  setId(int value) {
    id = value;
  }

  setUserName(String value) {
    userName = value;
  }

  setFirstName(String value) {
    firstName = value;
  }

  setLastName(String value) {
    lastName = value;
  }

  setPassword(String value) {
    password = value;
  }
}
