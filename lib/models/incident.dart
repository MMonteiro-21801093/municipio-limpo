import 'dart:io';

class Incident{
  String _incidentDate;
  String _title;
  String _description;
  String _address;
  String _state="Aberto";
  File _image;
  Incident();

  File get image => _image;
  set image(File value)=>_image = value;

  String get incidentDate => _incidentDate;
  set incidentDate(String value) =>_incidentDate = value;

  set state(String value) =>_state = value;
  String get state => _state;

  String get title => _title;
  set title(String value) =>  _title = value;

  String get address => _address;
  set address(String value)=>  _address = value;

  String get description => _description;
  set description(String value)=>  _description = value;




}