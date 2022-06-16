import 'dart:async';

import 'package:poke/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailConroller = BehaviorSubject<String>();
  final _passConroller = BehaviorSubject<String>();

//Recupera los datos del Stream//transform al agregar with validator podemos usa donde hacmos las condiciones de la validacion
  Stream<String> get emailStream =>
      _emailConroller.stream.transform(validarEmail);
  Stream<String> get passStream => _passConroller.stream.transform(validarPass);

//esto le dice al boton que se habilite cuando la info es correcta
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passStream, (e, p) => true);

//Insertar valores al Stream
  Function(String) get changeEmail => _emailConroller.sink.add;
  Function(String) get changePass => _passConroller.sink.add;

//Obtener el ultimo valor ingresado a los streams
  String get email => _emailConroller.value;
  String get pass => _passConroller.value;

  dispose() {
    _emailConroller.close();
    _passConroller.close();
  }
}
