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

    incidentBloc.loadIncident(incidentKey);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Município Limpo"),
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
                    'Detalhe do Incidente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:( Colors.blueGrey),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                   snapshot.data.image!=null ? Image.file(snapshot.data.image, fit: BoxFit.cover, height:200,width: 200.0): new Container(),
                  ColumnDetails(snapshot.data.title, "Titulo:"),
                  ColumnDetails(snapshot.data.incidentDate, "Data do registo:"),
                  ColumnDetails(snapshot.data.description, "Descrição:"),
                  ColumnDetails(snapshot.data.address, "Morada:"),
                  ColumnDetails(snapshot.data.state, "Estado:"),

                ],
              );
            }),
      ),
    );
  }
}
