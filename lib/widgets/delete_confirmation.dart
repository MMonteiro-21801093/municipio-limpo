import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/treatment_list.dart';

import 'delete_message.dart';

DeleteConfirmation(BuildContext context, TreatmentListBloc treatmentListBloc, incidentDate )
{


  Widget deleteButton = FlatButton(
    child: Text("Eliminar"),
    onPressed: () {
      treatmentListBloc.deleteIncident(incidentDate);
      DeleteMessage(context);

      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pop(); // dismiss dialog
      });



    },
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text("Incidente"),

    content: Text("Prendente eliminar o incidente selecionado?"),
    actions: [
      deleteButton,
      cancelButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}