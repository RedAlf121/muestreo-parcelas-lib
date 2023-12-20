import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/map%20pages/general_form.dart';

class PolygonalForm extends GeneralForm {
  PolygonalForm({required super.indexes, required super.components});

  
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: components,)
    );
  }
  
  @override
  void sendData() {
    // TODO: implement sendData
  }
}