import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

Future alerteSave(BuildContext context, IconData icon, String texto) {
  return AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          title: 'Succes',
          desc: texto,
          btnOkIcon: icon,
          onDissmissCallback: (_) {})
      .show();
}
