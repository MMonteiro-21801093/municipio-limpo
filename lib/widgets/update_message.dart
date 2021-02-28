
import 'package:flutter/material.dart';

UpdateMessage(BuildContext context,String action)
{
  String message ="";
  if(action =="N"){
    message = "submetido";
  }else{
    message = "editado";
  }
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Incidente"),

    content: Text("O seu incidente foi $message com sucesso"),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}