import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/treatment_list.dart';
import 'package:projeto_cm/screens/incident.dart';

import 'delete_confirmation.dart';
import 'delete_message.dart';
import 'modal_options.dart';

Widget TreatmentList(
    context, AsyncSnapshot snapshot, TreatmentListBloc treatmentListBloc) {
  treatmentListBloc.getData();
   _refresh() async{
     await Future.delayed(Duration(seconds: 3));
     var random = new Random();
     int index = random.nextInt(snapshot.data.length);
     treatmentListBloc.resolveIncident(snapshot.data[index].incidentDate);
    return null;
   }
  return  RefreshIndicator(onRefresh: _refresh,
    child:ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              ModalOptions(context, index,treatmentListBloc,
                  snapshot.data[index].incidentDate);
            },
            child: Card(
              shadowColor: Colors.black,
               color:snapshot.data[index].state=="A"? Colors.white70:Colors.grey,
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
                          Icons.search,
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
                      Text("        "),
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          //   treatmentListBloc.deleteIncident(snapshot.data[index].incidentDate);
                          DeleteConfirmation(context, treatmentListBloc,
                              snapshot.data[index].incidentDate);
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ));
      }),
  );
  }

