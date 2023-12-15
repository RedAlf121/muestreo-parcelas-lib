import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/mixins/loading_mixin.dart';
import 'package:muestreo_parcelas/utils/mixins/named_app_bar_mixin.dart';

class SpecificProperty extends StatefulWidget {
  const SpecificProperty({super.key});
  
  @override
  State<StatefulWidget> createState() => SpecificPropertyState();
}

class SpecificPropertyState extends State<SpecificProperty> with LoadingFuture, NamedAppBar {
  late final Icon leadingIcon;
  List<bool> states = [];
  final List<String> _list = List<String>.generate(10, (index) => 'Item $index');

  List<String> get list=>_list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        context: context,
        leading: IconButton(onPressed: ()=>Navigator.pop(context,[[]]), icon: const Icon(Icons.arrow_back_ios_new_rounded))
        ),    
      body: _createList(),
      floatingActionButton: _confirmationButton(context),//este boton debe regresar los elementos que se van a cambiar para luego el widget de planta o de suelo modifique la tabla correspondiente
    );
  }

  ListView _createList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        states.add(false);
        return Column(
          children: [
            const Divider(
              thickness: 1,
            ),
            SwitchListTile(

              value: states[index],
              title: Text(list[index]), //aqui pueden ir mas cosas segun lo que se lea
              subtitle: const Text(
                  'Valor'), //Aqui igual deberia leer del snapshot
              onChanged: (value)=>_changeValue(value,index),
            ),
          ],
        );
      },
    );
  }
  
  
  Widget _confirmationButton(context) {
    return FloatingActionButton(
      heroTag: 'specificProp',
      child: const Icon(Icons.upload_outlined),
      onPressed: (){
        Navigator.pop(context,[getOnData()]);
      },

    );
  }
  
  _changeValue(bool value, int index) {
    states[index] = !states[index];    
    setState(
      (){
        value = states[index];
      }
    );

  }
  
  List getOnData() {
    List onList = [];
    int index = 0;
    for (var element in list) {//aqui puede ser recorrer los nombres de las llaves
      if(states[index]){
        onList.add(element);//aqui puede solamente los nombres de los atributos
      }
      ++index;        
    }
    return onList;
  }
}
