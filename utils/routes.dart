import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/home%20pages/home.dart';
import 'package:muestreo_parcelas/gui/message%20pages/message_tab_page.dart';
import 'package:muestreo_parcelas/gui/message%20pages/specific_properties.dart';

import '../gui/map pages/main_map.dart';
import '../gui/user pages/user_info.dart';
import '../gui/user pages/log_in.dart';
import '../gui/user pages/sign_in.dart';

const homeRoute = 'home';
Map<String, Widget Function(BuildContext)> _map = {
    homeRoute : (BuildContext context)=>const HomePage(),
    'user'     : (BuildContext context) => UserInfo(),
    'messages' : (BuildContext context) => const MessagesPage(),
    'specific' : (BuildContext context) => const SpecificProperty(),
    'login'    : (BuildContext context) => const LogIn(),
    'signin'   : (BuildContext context) => const SignIn(),
    'main_map' : (BuildContext context) => const MainMapPage(),
  };
Map<String,WidgetBuilder>routesMap(){
  return _map;
}

WidgetBuilder home(){
  return _map[homeRoute]!;
}