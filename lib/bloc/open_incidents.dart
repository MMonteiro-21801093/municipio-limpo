import 'dart:async';
import 'dart:math';

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
    List outPutList =  listIncident.where((i) => i.state !="Fechado").toList();
    _input.add(outPutList);
}
  void deleteIncident(incidentDate) {
    List listIncident = db.getAll();
    for(int i = 0;i<listIncident.length;i++){
      if(listIncident[i].incidentDate == incidentDate ){
        db.deleteIncident(listIncident[i]);
        break;
      }
    }
    getOpenedIncidents();
  }

  void solveIncident() {
    var random = new Random();
    List listIncident = db.getAll();
    bool resolved = false;

    do{
      int index = random.nextInt(listIncident.length);
      if(listIncident[index].state =="Aberto"){
        listIncident[index].state ="Resolvido";
        resolved= true;
      }
    }while(resolved==false);
    _input.add(db.getAll());
   /* listIncident.forEach( (incident) {
      if(incident.incidentDate == incidentDate && incident.state =="Aberto"){
        incident.state ="Resolvido";
        _input.add(db.getAll()) ;
      }
    });*/

  }

  void closeIncident(incidentDate) {
    List listIncident = db.getAll();
    listIncident.forEach( (incident) {
      if(incident.incidentDate == incidentDate && incident.state == "Resolvido"){
        incident.state ="Fechado";
        getOpenedIncidents();
      }
    });
  }
  void insertIncident( data){
    db.updateDataBase(data);
    getOpenedIncidents();
  }
  void dispose()=> _controller.close();



}