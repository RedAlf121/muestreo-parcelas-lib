import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/message%20pages/ground_properties.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';
import 'package:muestreo_parcelas/utils/mixins/nav_bar_mixin.dart';
import '../../utils/mixins/loading_mixin.dart';
import '../../utils/mixins/named_app_bar_mixin.dart';
import 'plant_properties.dart';

// ignore: must_be_immutable
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with NamedAppBar, ElevatedNavigationBar<MessagesPage>, LoadingFuture {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> itemList = [
      const BottomNavigationBarItem(
          label: 'Plantas', icon: Icon(Icons.grass_outlined)),
      const BottomNavigationBarItem(
          label: 'Caracteristicas suelo', icon: Icon(Icons.grid_on_outlined)),
    ];
    return Scaffold(
      appBar: createAppBar(
        context: context,
        text: Text(
          'Mensajes',
          style: buildTextContext(context),
        ),
      ),
      bottomNavigationBar: createNavBar(      
        buttonList: itemList,
      ),
      body: PageView(
        controller: pageController,
        children: const [
          PlantProperty(),
          GroundProperty(),
        ],
      ),
    );
  }
}
