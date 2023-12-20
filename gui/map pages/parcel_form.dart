import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/map%20pages/general_form.dart';

class ParcelForm extends GeneralForm {
  ParcelForm({required super.indexes, required super.components});

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: components,
      ),
    );
  }
  
  @override
  void sendData() {
    // TODO: implement sendData
  }
}