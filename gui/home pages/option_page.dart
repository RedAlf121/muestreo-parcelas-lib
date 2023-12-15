import 'package:flutter/material.dart';
import '../others/themes_aux.dart';

// ignore: must_be_immutable
class OptionPage extends StatelessWidget {
  OptionPage({super.key});

  late List<Widget> tiles;
  @override
  Widget build(BuildContext context) {    
    tiles = [        
        InkWell(
          onTap: (){},
          child: ListTile(
            leading: const Icon(Icons.download),
            title: Text('Actualizar app', style: buildTextContext(context))),
          ),
        InkWell(
          onTap: (){},
          child: ListTile(
            leading: const Icon(Icons.monetization_on),
            title: Text('Donar a la app', style: buildTextContext(context))),
          ),
        InkWell(
          onTap: (){},
          child: ListTile(
            leading: const Icon(Icons.warning_amber_outlined),
            title: Text('Reportar un error', style: buildTextContext(context))),
          ),
        InkWell(
          onTap: (){},
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('Sobre nosotros', style: buildTextContext(context))),
          ),            
      ];
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: tilesFixed(),
    );
  }

  List<Widget> tilesFixed(){
    List<Widget> fixed = [InkWell(onTap: (){},child: tiles[0])];
    for(int i = 1; i < tiles.length; i++){
      fixed.addAll([const SizedBox(height:30),tiles[i]]);
    }
    return fixed;
  }
}