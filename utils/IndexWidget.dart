//La idea de este boton es poder conectar la lógica con algunos metodos de la interfaz

import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/formDialogue.dart';
import 'package:muestreo_parcelas/utils/my_dialog.dart';

import 'index_form_dialog.dart';

class IndexWidget extends StatelessWidget {
  final List<int> indexes;
  final Icon child;
  final List<Widget> form;
  final String? editing;
  final List<Widget>? actions;
  const IndexWidget({super.key, required this.indexes, required this.child, required this.form, this.editing, this.actions});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>openForm(context), 
      icon: child
    );
  }

  void openForm(context){
    showDialog(
      context: context, 
      builder: (builder){
        return IndexFormDialog(
          indexes: [],
          title: 'Editando la $editing', 
          form: form,                    
          actions: actions,
        );
      }
    );
  }

}