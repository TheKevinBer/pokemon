import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token login
  String get usuario {
    return _prefs.getString('usuario') ?? '';
  }

  set usuario(String value) {
    _prefs.setString('usuario', value);
  }

  // GET y SET del token
  String get pass {
    return _prefs.getString('pass') ?? '';
  }

  set pass(String value) {
    _prefs.setString('pass', value);
  }

  bool get check {
    return _prefs.getBool('check') ?? false;
  }

  set check(bool value) {
    _prefs.setBool('check', value);
  }

  void disconnect() {
    usuario = "";
    pass = "";
    check = false;
  }
}
