import 'dart:async';

import 'package:projeto_cm/data/database.dart';
import 'package:projeto_cm/models/incident.dart';

class IncidentBloc{

  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  DataBase db = DataBase.getInstance();

  void loadIncident(incidentKey) {
    List listIncident = db.getAll();
    listIncident.forEach( (incident) {
      if(incident.incidentDate == incidentKey){
        _input.add(incident) ;
      }
    });
  }
  void insertIncident( data){
    _input.add(data) ;
    db.updateDataBase(data);

  }
  void dispose()=> _controller.close();

  void updateIncident(Incident incident)=>_input.add(incident) ;


}