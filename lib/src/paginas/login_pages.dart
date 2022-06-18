import 'package:flutter/material.dart';
import 'package:poke/src/sharepreference/pref_user.dart';

import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';
import 'home_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? checkGuardarDatos = false;
  bool isLoading = false;
  final pref = PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    bool? check = false;
    const pageColor = Colors.pink;
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Container(
            color: pageColor,
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                                width: 190.0,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.none,
                                      image: AssetImage(
                                        'assets/images/logo/pokedex.jpg',
                                      ),
                                    ))),
                            const Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: pageColor.shade50,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(56.0),
                                topRight: Radius.circular(56.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const SizedBox(height: 48.0),
                              _ingncontrol(bloc),
                              const SizedBox(height: 24.0),
                              _ingPassword(bloc),
                              const SizedBox(
                                height: 36.0,
                              ),
                              CheckboxListTile(
                                value: checkGuardarDatos,
                                title: const Text(
                                  'Guardar mis credenciales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    checkGuardarDatos = value!;
                                    check = value;
                                    pref.check = value;
                                  });
                                },
                                secondary: const Icon(Icons.safety_check),
                              ),
                              StreamBuilder(
                                  stream: bloc.formValidStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    return snapshot.data != null
                                        ? FloatingActionButton(
                                            onPressed: () {
                                              ////ingresar
                                              FocusScope.of(context)
                                                  .unfocus(); //quita el teclado
                                              check = pref.check;
                                              if (check!) {
                                                pref.usuario = bloc.email;
                                                pref.pass = bloc.pass;
                                              }
                                              Navigator.pushReplacementNamed(
                                                  context, HomePage.routName);
                                            },
                                            backgroundColor: pageColor,
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          )
                                        : FloatingActionButton(
                                            onPressed: null,
                                            backgroundColor: pageColor.shade100,
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          );
                                  }),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  Widget _ingncontrol(LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (snapshot.error == null)
                const SizedBox(
                    width: 14,
                    height: 10,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    )),
              if (snapshot.error != null)
                const SizedBox(
                    width: 14,
                    height: 25,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    )),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: size.width / 1.3,
                    height: 80,
                    child: Card(
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextField(
                        //keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          //prefixIcon: Icon(Icons.person),
                          hintText: "Usuario",
                          //labelText: 'Usuario',
                          hintStyle: TextStyle(
                              fontFamily: "Montserrat", color: Colors.grey),
                          //errorText: snapshot.error,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 16.0),
                        ),
                        onChanged: bloc.changeEmail,
                      ),
                    ),
                  ),
                  if (snapshot.error != null)
                    Text(
                      "${snapshot.error}",
                      style: const TextStyle(
                          color: Color.fromRGBO(230, 0, 50, 1.0)),
                    ),
                ],
              ),
            ],
          );
        });
  }

  Widget _ingPassword(LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.passStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (snapshot.error == null)
                const SizedBox(
                    width: 14,
                    height: 10,
                    child: Icon(
                      Icons.lock,
                      size: 40,
                      color: Colors.white,
                    )),
              if (snapshot.error != null)
                const SizedBox(
                    width: 14,
                    height: 25,
                    child: Icon(
                      Icons.lock,
                      size: 40,
                      color: Colors.white,
                    )),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: size.width / 1.3,
                    height: 80,
                    child: Card(
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextField(
                          obscureText: true,
                          autofocus: false,
                          decoration: const InputDecoration(
                            hintText: 'Contraseña ',
                            //counterText: snapshot.data,
                            //errorText: snapshot.error,
                            hintStyle: TextStyle(
                                fontFamily: "Montserrat", color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 16.0),
                          ),
                          onChanged: bloc.changePass),
                    ),
                  ),
                  if (snapshot.error != null)
                    Text(
                      "${snapshot.error}",
                      style: const TextStyle(
                          color: Color.fromRGBO(230, 0, 50, 1.0)),
                    ),
                ],
              ),
            ],
          );
        });
  }
}
