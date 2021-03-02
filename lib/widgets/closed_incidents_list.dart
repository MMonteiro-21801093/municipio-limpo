import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/closed_incidents.dart';
import 'package:projeto_cm/screens/incident_details.dart';
class ClosedIncidentsList extends StatefulWidget {

  ClosedIncidentsList();

  @override
  _ClosedIncidentsListState createState() => _ClosedIncidentsListState();
}

class _ClosedIncidentsListState extends State<ClosedIncidentsList> {
  final  closedIncidentsBloc = ClosedIncidentsBloc();

  @override
  void dispose() {
    closedIncidentsBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return   StreamBuilder(initialData:[],stream: closedIncidentsBloc.output, builder: (BuildContext context,snapshot){
      return BuildList(context,snapshot,closedIncidentsBloc);
    });
  }
  Widget BuildList(
      context, AsyncSnapshot snapshot, ClosedIncidentsBloc closedIncidentsBloc) {
      closedIncidentsBloc.getClosedIncidents();

    return ListView.builder(

          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return  Card(
                    shadowColor: Colors.black,
                    color:Colors.white70,
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
                                        builder: (context) => IncidentDetailsScreen(snapshot.data[index].incidentDate)));
                              },
                            ),



                          ]),
                        ),
                      ],
                    ),
                );
          });

  }

}