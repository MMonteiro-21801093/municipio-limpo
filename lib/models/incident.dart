class Incident{
  String _incidentDate;
  String _incidentTitle;
  String _description;
  String _address;
  String _state="A";
  Incident();

  String get incidentDate => _incidentDate;

  set incidentDate(String value) =>_incidentDate = value;

  set state(String value) =>_state = value;

  String get incidentTitle => _incidentTitle;

  String get state => _state;

  String get address => _address;

  set address(String value)=>  _address = value;

  String get description => _description;

  set description(String value)=>  _description = value;

  set incidentTitle(String value) =>  _incidentTitle = value;


}