import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

mixin FieldValidate{
  List<TextEditingController> controllers = [];
  bool passAll(){
    bool check = !voidComponents();
    if(!check){

    }
    return check;
  }
  
  bool voidComponents() {
    bool check = controllers.isEmpty;
    
    for(int i = 0; i < controllers.length && !check; i++){
      check = controllers[i].text.isEmpty;
    }

    return check;
  }

  Future<PostgreSQLResult?> getUser(provider) async {
    PostgreSQLResult? postgreSQLResult;

    return Future.delayed(const Duration(seconds: 3),()=>postgreSQLResult);
  }

}