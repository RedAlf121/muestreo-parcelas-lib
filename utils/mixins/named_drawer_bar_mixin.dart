import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app.dart';
import '../../gui/others/themes_aux.dart';

mixin DrawerBar {
  Drawer createDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        children: drawerContent(context),
      ),
    );
  }

  IconButton darkMode(BuildContext context) {
    return IconButton(
      onPressed: () =>
          context.findAncestorStateOfType<MyAppState>()?.switchMode(),
      icon: Icon((Theme.of(context).brightness == Brightness.light)
          ? Icons.dark_mode
          : Icons.sunny),
    );
  }

  InkWell exitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        //Dar dispose antes a las clases necesarias
        SystemNavigator.pop(animated: true);
      },
      child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text('Salir de la app', style: buildTextContext(context))),
    );
  }

  InkWell userButton(BuildContext context){
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, 'user');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      },
      child: ListTile(
        leading: const Icon(Icons.account_circle_outlined),
        title: Text('Perfil', style: buildTextContext(context)),
      ),
    );
  }

  List<Widget> drawerContent(BuildContext context){
    return [
      darkMode(context),
      userButton(context),
      exitButton(context),
    ];
  }
}