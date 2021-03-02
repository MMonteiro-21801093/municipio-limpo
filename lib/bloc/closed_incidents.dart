import 'dart:async';

import 'package:projeto_cm/data/database.dart';


class ClosedIncidentsBloc{
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  DataBase db = DataBase.getInstance();

  void getClosedIncidents(){
    List listIncident = db.getAll()  ;
    List outPutList= List() ;
    if(listIncident.length> 0){

      for(int i = 0; i < listIncident.length;i++){
        if( listIncident[i].state == "Fechado"  ){
          outPutList.add(listIncident[i]);
        }
      }
      _input.add(outPutList);
    }else{
      _input.add(listIncident);
    }
  }


  void dispose()=> _controller.close();



}