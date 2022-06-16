import 'package:flutter/material.dart';
import 'package:poke/src/paginas/login_pages.dart';

import '../paginas/detail_screen.dart';
import '../paginas/home_pages.dart';

Map<String, WidgetBuilder> getapplicationRoutes() {
  final rutas = <String, WidgetBuilder>{
    'home': (BuildContext context) => const HomePage(),
    'login': (BuildContext context) => const LoginPage(),
    'detail': (BuildContext context) => const DetailScreen(),
  };

  return rutas;
}
