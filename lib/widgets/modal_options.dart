import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_cm/screens/incident.dart';
import 'package:projeto_cm/screens/incident_details.dart';

import 'delete_message.dart';

void ModalOptions(BuildContext context, int index,   [treatmentListBloc,incidentDate]) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton.icon(
                onPressed: () {

                 Navigator.push(
                  context,
                   MaterialPageRoute(
                   builder: (context) => IncidentDetailsScreen(incidentDate)));

                },
                label: Text(
                  'Detalhe ',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.details,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IncidentScreen("E",
                              incidentKey:
                              incidentDate)));
                },
                label: Text(
                  'Editar    ',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton.icon(
                onPressed: () {
                  treatmentListBloc.deleteIncident(incidentDate);
                  DeleteMessage(context);
                  Timer(Duration(seconds: 3), () {
                    Navigator.of(context).pop();
                  });
                },
                label: Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      );
    },
  );
}
