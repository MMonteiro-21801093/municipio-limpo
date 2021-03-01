import 'dart:async';

import 'package:projeto_cm/data/database.dart';

class TreatmentListBloc{
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  DataBase db = DataBase.getInstance();

  void getData() {
    _input.add(db.getAll());
  }

  void deleteIncident(incidentDate) {
    List listIncident = db.getAll();
    for(int i = 0; i < listIncident.length;i++){
      if(listIncident[i].incidentDate == incidentDate){
        db.deleteIncidente(listIncident[i]);
        _input.add(db.getAll()) ;
        break;
      }

    }
  }

  void resolveIncident(incidentDate) {
    List listIncident = db.getAll();
    for(int i = 0; i < listIncident.length;i++){
      if(listIncident[i].incidentDate == incidentDate){
        listIncident[i].state ="R";
        _input.add(db.getAll()) ;
        break;
      }
  }
  }




}