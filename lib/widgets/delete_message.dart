import 'dart:async';

import 'package:flutter/material.dart';

DeleteMessage(BuildContext context)
{
  Timer(Duration(seconds: 3), () {
    Navigator.of(context).pop(); // dismiss dialog
  });
 
  AlertDialog alerta = AlertDialog(
    title: Text("Incidente"),

    content: Text("O incidente selecionado foi eliminado com sucesso"),
    actions: [

    ],
  );

  showDialog(

    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}