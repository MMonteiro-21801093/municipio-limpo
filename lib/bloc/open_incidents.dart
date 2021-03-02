import 'dart:async';

import 'package:projeto_cm/data/database.dart';


class OpenIncidentsBloc{
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  DataBase db = DataBase.getInstance();

  void getData() {
    _input.add(db.getAll());
  }
  void getOpenedIncidents(){
    List listIncident = db.getAll()  ;
    List outPutList= List() ;
    if(listIncident.length> 0){
      for(int i = 0; i < listIncident.length;i++){
        if( listIncident[i].state != "Fechado"  ){
          outPutList.add(listIncident[i]);
        }
      }

    }
    _input.add(outPutList);
}
  void deleteIncident(incidentDate) {
    List listIncident = db.getAll();
    for(int i = 0; i < listIncident.length;i++){
      if(listIncident[i].incidentDate == incidentDate){
        db.deleteIncident(listIncident[i]);
        getOpenedIncidents();
        break;
      }

    }
  }

  void solveIncident(incidentDate) {
    List listIncident = db.getAll();
    //for(int i = 0; i < listIncident.length;i++){
    // if(listIncident[i].incidentDate == incidentDate && listIncident[i].state == "Aberto"){
    //   listIncident[i].state ="Resolvido";
    //    _input.add(db.getAll()) ;
    //    break;
    // }
  //}

    listIncident.forEach( (incident) {
      if(incident.incidentDate == incidentDate && incident.state =="Aberto"){
        incident.state ="Resolvido";
        _input.add(db.getAll()) ;
      }
    });

  }

  void closeIncident(incidentDate) {
  //  db.updateDataBase(data);
    List listIncident = db.getAll();
    for(int i = 0; i < listIncident.length;i++){
      if(listIncident[i].incidentDate == incidentDate && listIncident[i].state == "Resolvido"){
        listIncident[i].state ="Fechado";
        getOpenedIncidents();
        break;
      }
    }


  }
  void insertIncident( data){

    db.updateDataBase(data);
    getOpenedIncidents();
  }
  void dispose()=> _controller.close();



}