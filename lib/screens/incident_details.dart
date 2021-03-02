import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/incident.dart';
import 'package:projeto_cm/models/incident.dart';
import 'package:projeto_cm/widgets/column_details.dart';
import 'package:projeto_cm/widgets/update_message.dart';

class IncidentDetailsScreen extends StatelessWidget {
  IncidentDetailsScreen(this.incidentKey);

  final incidentKey;

  final incidentBloc = IncidentBloc();

  @override
  Widget build(BuildContext context) {

      //    MaterialPageRoute(
      //     builder: (context) => IncidentDetailsScreen(incidentDate)));
    incidentBloc.loadIncident(incidentKey);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Municipio Limpo"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: StreamBuilder(
            initialData: null,
            stream: incidentBloc.output,
            builder: (BuildContext context, snapshot) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Consulta de Incidentes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ColumnDetails(snapshot.data.title, "Titulo"),
                  ColumnDetails(snapshot.data.incidentDate, "Data do registo"),
                  ColumnDetails(snapshot.data.description, "Descrição"),
                  ColumnDetails(snapshot.data.address, "Morada"),
                  Text(
                    snapshot.data.state,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: snapshot.data.state == "Aberto" ? Colors.blueAccent : snapshot.data.state =="Resolvido" ? Colors.orangeAccent : Colors.redAccent,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
