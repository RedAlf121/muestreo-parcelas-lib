// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/home%20pages/main_page.dart';
import 'package:muestreo_parcelas/utils/mixins/named_drawer_bar_mixin.dart';
import 'package:postgres/postgres.dart';
import '../../utils/mixins/named_app_bar_mixin.dart';
import '../../utils/mixins/nav_bar_mixin.dart';
import '../others/themes_aux.dart';
import 'news.dart';
import 'option_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage>
    with NamedAppBar, DrawerBar, ElevatedNavigationBar<HomePage> {
  final homeText = ['Novedades', 'Forestal', 'Ajustes'];
  HomeState() {
    buildLateNavBar(firstIndex: 1);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: createAppBar(
        context: context,
        text: Text(
          homeText[index],
          style: buildTextContext(context),
        ),
      ),
      body: _createBody(),
      bottomNavigationBar: createNavBar(
        buttonList: [
          newsButton(context),
          homeButton(),
          settingsButton(),
        ],
      ),
      drawer: createDrawer(context),
    );
  }

  BottomNavigationBarItem settingsButton() =>
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: '');

  BottomNavigationBarItem homeButton() {
    return const BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined), label: '');
  }

  BottomNavigationBarItem newsButton(BuildContext context) {
    return BottomNavigationBarItem(
        icon: Stack(
          children: [
            notification(context),
            const Icon(Icons.forest),
          ],
        ),
        label: '');
  }

  Positioned notification(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: (canHide())
              ? Colors.transparent
              : (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.amber
                  : const Color.fromARGB(255, 238, 255, 7),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() => becomeListener());
  }

  bool canHide() {
    index == 0;
    //TODO
    //Hacer verificacion de si hay nuevas notificaciones
    //Para futuras versiones de la aplicacion
    return true;
  }

  Widget _createBody() {
    return PageView(
      onPageChanged: (index){
        setState((){});
      },
      controller: pageController,
      children: [
        const NewsPage(),
        const MainPage(),
        OptionPage(),
      ],
    );
  }
}
