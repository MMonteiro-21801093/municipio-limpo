import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/treatment_list.dart';
import 'package:projeto_cm/widgets/treatment_list.dart';

import 'incident.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key key, this.title});



  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>  {

  final treatmentListBloc = TreatmentListBloc();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Municipio Limpo'),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Em Tratamento",style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  ),

                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Fechados",style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  ),

                ),

              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(initialData:[],stream: treatmentListBloc.output, builder: (BuildContext context,snapshot) {
                return TreatmentList(context,snapshot,treatmentListBloc);
              }         ),
              Icon(Icons.directions_transit),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                  context,MaterialPageRoute(builder: (context)=>IncidentScreen("N"))
              );
            },
          ),
        )

    );

  }


}



