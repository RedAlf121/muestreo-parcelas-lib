import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/mixins/loading_mixin.dart';

abstract class Property extends StatefulWidget{
  const Property({super.key});

}

abstract class PropertyState<T> extends State with LoadingFuture{
  late final Icon leadingIcon;
  int _firstSelected = -1; // Variable para rastrear si se ha seleccionado un elemento
  List<bool> _selectedItems = [];

  @override
  Widget build(BuildContext context) {    
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (_selectedItems.isEmpty) {
          _selectedItems = List<bool>.filled(snapshot.data?.length ?? 0, false); // Inicializa _selectedItems con la longitud de los datos
        }
        return buildContent(
          context: context, 
          snapshot: snapshot, 
          contentWidget: Stack(
            children: [
              _createList(snapshot),
              if (_firstSelected != -1) _confirmationButton(context), // El botón solo se muestra si _isSelected es verdadero
            ],
          ),
        );
      },
    );
  }

  ListView _createList(snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const Divider(thickness: 1,),                      
            (_firstSelected != -1)? createCheckListTile(snapshot, index, context) : createListTile(snapshot, index, context),            
          ],
        );
      },
    );
  }

  ListTile createListTile(snapshot, int index, BuildContext context) {
    return ListTile(
            trailing: const Icon(Icons.arrow_right_rounded),
            leading: leadingIcon,
            title: Text(snapshot.data[index]),//aqui pueden ir mas cosas segun lo que se lea
            subtitle: const Text('Nombre usuario'),//Aqui igual deberia leer del snapshot
            onTap: (){
              showData(context);                
            },
            onLongPress: () {
              setState(() {
                _firstSelected = index; // Cambia _isSelected a verdadero cuando se selecciona un elemento
                _selectedItems[index] = true; // Marca el elemento seleccionado como verdadero en _selectedItems
              });
            },              
          );
  }

  Widget _confirmationButton(context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Row(
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'acceptButton',
            child: const Icon(Icons.check),
            onPressed: (){
              setState(clean);
              // Aquí puedes agregar la lógica para el botón de aceptar
            },
          ),
          FloatingActionButton(
            heroTag: 'acceptButton',
            child: const Icon(Icons.delete_outline_rounded),
            onPressed: (){
              setState(clean);
              // Aquí puedes agregar la lógica para el botón de aceptar
            },
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'rejectButton',
            child: const Icon(Icons.close),
            onPressed: ()=>setState(clean)
          ),
        ],
      ),
    );
  }

  void clean() {
    _firstSelected = -1; // Cambia _isSelected a falso cuando se presiona el botón de rechazo
    _selectedItems = List<bool>.filled(_selectedItems.length, false); // Desmarca todos los elementos cuando se presiona el botón de rechazo
  }

  CheckboxListTile createCheckListTile(snapshot, int index, BuildContext context) {  
    return CheckboxListTile(
              value: _selectedItems[index],
              onChanged: (bool? value) {
                setState(() {
                  _selectedItems[index] = value!;
                });
              },
              title: Text(snapshot.data[index]),//aqui pueden ir mas cosas segun lo que se lea
              subtitle: const Text('Nombre usuario'),//Aqui igual deberia leer del snapshot
              secondary: leadingIcon,
            );
  }

  Future getData();//getData es responsable de halar de la BD  
  void showData(BuildContext context);//showData debe enviar los datos de planta o suelo en funcion de 
}
