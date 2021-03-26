import 'dart:async';
import 'package:projeto_cm/data/database.dart';

class ClosedIncidentsBloc{
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  DataBase db = DataBase.getInstance();

  void getClosedIncidents(){
    List listIncident = db.getAll()  ;
    List outPutList =  listIncident.where((i) => i.state =="Fechado").toList();
    _input.add(outPutList);
  }
  void dispose()=> _controller.close();



}