import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/map%20pages/general_form.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';

import '../../utils/delete_button.dart';

class InfoForm extends StatefulWidget {
  final List<int> indexes;
  final GeneralForm form;
  final List<Widget>? exportButtons;
  const InfoForm({super.key, required this.form, required this.indexes,this.exportButtons});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late Widget actualForm;
  
  @override
  void initState() {
    super.initState();
    actualForm = SingleChildScrollView(
      child: Column(
        children:  [
            FloatingActionButton.extended(
              icon: Icon(Icons.edit_location_alt_outlined),
                heroTag: 'edit',
                onPressed: () => setState(() => actualForm = widget.form),
                label: const Text(
                  'Editar',
                  style: TextStyle(color: Colors.white,),          
                )),
            SizedBox(height: 10,),
      
            ...widget.exportButtons ?? [],//desempaqueta los elementos de una lista y los devuelve de uno en uno asi concateno las listas en una posicion en especifico
      
            SizedBox(height: 10,),
            DeleteButton(
              title: 'Eliminando',
              prompt: '¿Desea eliminar el elemento seleccionado?',
              text: Text('Eliminar'),
              func: () {
                //widget.indexes;
              },
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return actualForm;
  }
}
