import 'dart:async';

//r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern = r'^([0-9]{5})*$';
    RegExp regExp = RegExp(pattern as String);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('El usuario no es correcto');
    }
  });

  final validarPass = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 5) {
      sink.add(password);
    } else {
      sink.addError('Más de 5 caracteres por favor');
    }
  });

  final validarusuario =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern = r'^([a-z\u00f1\u00d1])*$';
    RegExp regExp = RegExp(pattern as String);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('El usuario no es correcto');
    }
  });
}
