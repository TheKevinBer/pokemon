import 'package:flutter/material.dart';
import 'package:poke/src/paginas/equipos_pages.dart';
import 'package:poke/src/paginas/loading_page.dart';
import 'package:poke/src/paginas/login_pages.dart';

import '../paginas/detail_screen.dart';
import '../paginas/home_pages.dart';
import '../paginas/teamview_pages.dart';

Map<String, WidgetBuilder> getapplicationRoutes() {
  final rutas = <String, WidgetBuilder>{
    'home': (BuildContext context) => const HomePage(),
    'login': (BuildContext context) => const LoginPage(),
    'detail': (BuildContext context) => const DetailScreen(),
    'loading': (BuildContext context) => const LoadingPage(),
    'equipos': (BuildContext context) => const EquipoPages(),
    'equipoview': (BuildContext context) => const EquipoView(),
  };

  return rutas;
}
