import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/logic/sampling.dart';
import 'package:postgres/postgres.dart';

mixin FieldValidate{
  List<TextEditingController> controllers = [];
  bool passAll(){
    bool check = !voidComponents();
    return check;
  }
  
  bool voidComponents() {
    bool check = controllers.isEmpty;
    
    for(int i = 0; i < controllers.length && !check; i++){
      check = controllers[i].text.isEmpty;
    }

    return check;
  }

  Future<void> getUser(List<String>provider) async {
    
    singletonSampling.loginUser(provider.first, provider.last);
  }

}