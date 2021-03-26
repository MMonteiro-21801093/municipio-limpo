
import 'package:flutter/material.dart';

UpdateMessage(BuildContext context,String action)
{
  String message;
  if(action =="N"){
    message = "submetido";
  }else{
    message = "editado";
  }

  Widget okButton = FlatButton(
    child: Text("OK",
        style: TextStyle(
      color: Colors.blueGrey,fontSize: 15,
      // fontWeight: FontWeight.bold,
    )),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text("Gestão de Incidentes",
      style: TextStyle(
        color: Colors.blueGrey,)
    ),

    content: Text("O seu incidente foi $message com sucesso",
        style: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
           )
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}