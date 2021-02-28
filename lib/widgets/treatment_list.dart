
import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/treatment_list.dart';
import 'package:projeto_cm/screens/incident.dart';

import 'delete_confirmation.dart';

Widget TreatmentList(context, AsyncSnapshot snapshot, TreatmentListBloc treatmentListBloc){
  treatmentListBloc.getData();

  return ListView.builder(

      itemCount:snapshot.data.length,
      itemBuilder: (context,index){
        return Card(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAlias,
          child:Column(
            children: [

              ListTile(
                title: Text(snapshot.data[index].incidentTitle),
                subtitle: Text(snapshot.data[index].incidentDate),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent,),
                        onPressed:(){
                          Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>IncidentScreen("E",incidentKey:snapshot.data[index].incidentDate))
                          );
                        },
                      ),


                      Text( "        "),
                      IconButton(
                        icon: Icon(Icons.delete_forever, color: Colors.red,),
                        onPressed:(){
                          //   treatmentListBloc.deleteIncident(snapshot.data[index].incidentDate);
                          DeleteConfirmation(context,  treatmentListBloc,snapshot.data[index].incidentDate);

                        },
                      ),
                    ]),
              ),
            ],
          ) ,
        );
      }
  );
}