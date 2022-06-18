import 'package:flutter/material.dart';
import 'package:poke/src/routes/routes.dart';
import 'package:poke/src/sharepreference/pref_user.dart';
import 'package:flutter/services.dart';

import 'src/bloc/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  //para ingresar
  await prefs.initPrefs();
  //ChangeNotifierProvider(create: (_) => ScanListProvider());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Provider(
        child: MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Pokemon',
      initialRoute: "loading",
      routes: getapplicationRoutes(),
      theme: ThemeData(
          //color del la vista morado letras
          primaryColor: Colors.green),
      builder: (context, child) {
        return child!;
      },
    ));
  }
}
