import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/open_incidents.dart';
import 'package:projeto_cm/screens/incident.dart';
import 'package:projeto_cm/screens/incident_details.dart';

class OpenIncidentList extends StatefulWidget {
  OpenIncidentList();

  @override
  _OpenIncidentListState createState() => _OpenIncidentListState();
}

class _OpenIncidentListState extends State<OpenIncidentList> {
  final openIncidentsBloc = OpenIncidentsBloc();

  @override
  void dispose() {
    openIncidentsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    openIncidentsBloc.getOpenedIncidents();
    return StreamBuilder(
        initialData: [],
        stream: openIncidentsBloc.output,
        builder: (BuildContext context, snapshot) {
          return TreatmentList(context, snapshot, openIncidentsBloc);
        });
  }

  Widget TreatmentList(
      context, AsyncSnapshot snapshot, OpenIncidentsBloc openIncidentsBloc) {
    openIncidentsBloc.getOpenedIncidents();

    _refreshToResolveIncident() async {
      await Future.delayed(Duration(seconds: 2));
      openIncidentsBloc.solveIncident();
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Um dos seus incidentes foi dado como resolvido. ",
            style: TextStyle(color: Colors.white, fontSize: 15)),
      ));
      return null;
    }

    void _deleteIncident(AsyncSnapshot snapshot, int index) {
      setState(() {
        if (snapshot.data[index].state == "Aberto") {
          openIncidentsBloc.deleteIncident(snapshot.data[index].incidentDate);
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text("O incidente selecionado foi eliminado com sucesso.",
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "O incidente selecionado não pode ser eliminado pois já se encontra resolvido.",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ));
        }
      });
    }

    void _editIncident(AsyncSnapshot snapshot, int index) {
      setState(() {
        if (snapshot.data[index].state == "Aberto") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IncidentScreen("E",
                      incidentKey: snapshot.data[index].incidentDate)));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "O incidente selecionado não pode ser editado pois já se encontra resolvido.",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ));
        }
      });
    }

    return RefreshIndicator(
      onRefresh: _refreshToResolveIncident,
      child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(snapshot.data[index].incidentDate),
              confirmDismiss: (direction) async {
                if (snapshot.data[index].state == "Aberto") {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                        "Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ));
                  return false;
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      "O seu incidente foi dado como fechado.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ));
                  return true;
                }
              },
              background: Container(
                color: Colors.blueGrey,
                child: Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.update,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                setState(() {
                  openIncidentsBloc
                      .closeIncident(snapshot.data[index].incidentDate);
                  snapshot.data.removeAt(index);
                });
              },
              child: Card(
                shadowColor: Colors.black,
                color: snapshot.data[index].state == "Aberto"
                    ? Colors.white
                    : Colors.white54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].incidentDate),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IncidentDetailsScreen(snapshot
                                                .data[index].incidentDate)));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () => _editIncident(snapshot, index),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () => _deleteIncident(snapshot, index),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
