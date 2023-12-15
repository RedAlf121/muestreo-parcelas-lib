import 'package:flutter/material.dart';

import '../../gui/home pages/home.dart';
import '../routes.dart';


mixin NamedAppBar{
  AppBar createAppBar({
    required BuildContext context, 
    Text? text,
    Widget? leading,
    Widget? title,    
    }) {
    text ??= const Text('');
    return AppBar(
      leading: leading ?? defaultLeading(context), 
      title: title ?? defaultTitle(context,text)
    );
  }

  AppBar createAppTabBar({
      required BuildContext context,
      Text? text,
      required List<Tab> tabsList,
      Widget? leading,
      Widget? title
      }) {
    text ??= const Text('');
    return AppBar(
      leading: leading ?? defaultLeading(context),
      title: title ?? defaultTitle(context,text),
      bottom: TabBar(
        tabs: tabsList,
      ),
    );
  }

  Row defaultTitle(context,Text text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: appBarContent(context,text),
    );
  }

  IconButton? defaultLeading(BuildContext context) =>
      (ModalRoute.of(context)?.settings.name == homeRoute)
          ? null
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded));

  List<Widget> appBarContent(context,Text text) {
    return [
      text,
      const Expanded(child: SizedBox()),
      IconButton(
        onPressed: ()=>jumpHome(context),
        iconSize: 80,
        icon: Image.asset(
          'assets/icons/_e004daa2-f140-43a6-8b56-b92789e32c8b-removebg-preview.png',
        ),
      ),
      const Text('Foresba'),
    ];
  }
  void jumpHome(context){
    Navigator.popUntil(context, (route) => route.settings.name != homeRoute);
  }
}
