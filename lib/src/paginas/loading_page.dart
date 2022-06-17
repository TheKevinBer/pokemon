import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poke/src/paginas/home_pages.dart';

import '../sharepreference/pref_user.dart';
import 'login_pages.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Image.asset(
              "assets/images/new/JO4d.gif",
              height: 60,
              width: 60,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final pref = PreferenciasUsuario();
    if (pref.check == true && pref.usuario != "" && pref.pass != "") {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, HomePage.routName);
      });
    } else {
      pref.disconnect();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const LoginPage(),
                transitionDuration: const Duration(milliseconds: 100)));
      });
    }
  }
}
