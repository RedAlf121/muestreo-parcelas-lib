import 'package:flutter/material.dart';

import '../others/themes_aux.dart';
int _homeIndex = 0;
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
Widget build(BuildContext context) {
  const sizedBox = SizedBox(height: 40,);
  return ListView( 
    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),   
    children: [    
      buildButtonWithText(context: context, icon: const Icon(Icons.add), text: 'Crear muestreo',func: (){}),
      sizedBox,
      buildButtonWithText(
        context: context, 
        icon: const Icon(Icons.location_on_outlined), 
        text: 'Buscar en el mapa',
        func: (){
          Navigator.pushNamed(context, 'main_map');
        }),          
      sizedBox,
      buildButtonWithText(context: context, icon: const Icon(Icons.document_scanner), text: 'Exportar a Excel',func: (){}),
      sizedBox,
      buildButtonWithText(context: context, icon: const Icon(Icons.help_outline), text: 'Ayuda',func: (){}),
    ],
  );
}

Widget buildButtonWithText({required BuildContext context, Icon? icon, required String text, void Function()? func}) {
  return Row(
    children: [
      Stack(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(80),
              onTap: func,
              child: Row(
                children: [
                  const SizedBox(height: 50,width: 60),
                  Text(text, style: buildTextContext(context)),
                  const SizedBox(width: 20),
                ],
              )
            ),
          ),
          FloatingActionButton(
            heroTag: 'home${_homeIndex++}',
            onPressed: func,
            child: icon,
          ),
        ],
      ),
    ],
  );
}
}
