import 'package:flutter/material.dart';

import 'login_bloc.dart'; //para poder usr el loginbloc

class Provider extends InheritedWidget {
  static Provider? _instancia;
  factory Provider({Key? key, Widget? child}) {
    _instancia ??= Provider._internal(key: key, child: child!);
    return _instancia!;
  }
  Provider._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  final loginBloc = LoginBloc();
  //Provider({ Key key, Widget child}): super(key:key,child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }
}
