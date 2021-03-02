
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/open_incidents.dart';
import 'package:projeto_cm/models/incident.dart';


import 'package:projeto_cm/screens/incident.dart';

import 'modal_options.dart';
class OpenIncidentList extends StatefulWidget {

  OpenIncidentList();

  @override
  _OpenIncidentListState createState() => _OpenIncidentListState();
}

class _OpenIncidentListState extends State<OpenIncidentList>  {
  final treatmentListBloc = OpenIncidentsBloc();
  @override
  void dispose() {
    treatmentListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    treatmentListBloc.getOpenedIncidents();
    return   StreamBuilder(initialData:[],stream: treatmentListBloc.output, builder: (BuildContext context,snapshot){
          return TreatmentList(context,snapshot,treatmentListBloc);
    });
  }

  Widget TreatmentList(
      context, AsyncSnapshot snapshot, OpenIncidentsBloc treatmentListBloc) {
    treatmentListBloc.getOpenedIncidents();
    _refreshToResolveIncident() async{
      await Future.delayed(Duration(seconds: 2));
      var random = new Random();
      int index = random.nextInt(snapshot.data.length);
      treatmentListBloc.solveIncident(snapshot.data[index].incidentDate);
      return null;
    }
    return RefreshIndicator(onRefresh: _refreshToResolveIncident,
      child:ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: Key(snapshot.data[index].incidentDate),
                confirmDismiss: (direction) async {
                  if (snapshot.data[index].state=="Aberto") {
                    Scaffold
                        .of(context)
                        .showSnackBar(
                        SnackBar(
                          content:
                          Text(
                              "Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados"
                              ),
                        ));
                    return false;
                  } else  {
                    Scaffold
                        .of(context)
                        .showSnackBar(
                        SnackBar(
                          content:
                          Text(
                              "O seu incidente foi dado como fechado"),
                        ));
                    return true;
                  }
                },
                background: Container(
                  color: Colors.blueAccent,
                  child: Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(Icons.update, color: Colors.white,),
                  ),
                ),
                direction: DismissDirection.startToEnd,//direçao do dismiss
                onDismissed: (direction){


                    setState(() {

                    //  Incident incident = snapshot.data[index];
                   //   incident.state="Fechado";
                      treatmentListBloc.closeIncident(snapshot.data[index].incidentDate);
                      snapshot.data.removeAt(index);


                    });


                },
                child:GestureDetector(
                  onTap: () {

                    ModalOptions(context, index,treatmentListBloc,
                        snapshot.data[index].incidentDate);
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color:snapshot.data[index].state=="Aberto"? Colors.white70:Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].incidentDate),
                          trailing:
                          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.book,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IncidentScreen("E",
                                            incidentKey:
                                            snapshot.data[index].incidentDate)));
                              },
                            ),
                            Text("        "),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IncidentScreen("E",
                                            incidentKey:
                                            snapshot.data[index].incidentDate)));
                              },
                            ),

                          ]),
                        ),
                      ],
                    ), ),
                ));
          }),
    );
  }

}
