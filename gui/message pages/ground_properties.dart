import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/message%20pages/properties.dart';

class GroundProperty extends Property{
  const GroundProperty({super.key});

  @override
  State<StatefulWidget> createState() => GroundPropertyState();

}

class GroundPropertyState extends PropertyState<GroundProperty>{
  
  GroundPropertyState(){
    leadingIcon = const Icon(Icons.landslide_outlined);
  }

  @override
  Future getData() {
    return Future.delayed(const Duration(seconds: 5), () {
      return List<String>.generate(10, (index) => 'Item $index');
    });
  }
  
  @override
  void showData(context)async {
   // TODO: implement showData    
    //Se deberia llamar un Navigator con los parametros correspondientes
    List parameters = await Navigator.pushNamed(context, 'specific') as List;
    print(parameters);//aqui iria la consulta que le daria update a null en ese caso
  }

}