


import 'package:flutter/material.dart';
import 'package:projeto_cm/bloc/incident.dart';
import 'package:projeto_cm/models/incident.dart';
import 'package:projeto_cm/widgets/update_message.dart';

class IncidentScreen extends StatelessWidget{
  IncidentScreen(this._action, {String this.incidentKey});
  final String _action;
  final incidentKey;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final incidentBloc = IncidentBloc();

  @override
  Widget build(BuildContext context) {

    if ( _action == "E") {
      incidentBloc.loadIncident( incidentKey);
    }
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: StreamBuilder(
                initialData: null,
                stream: incidentBloc.output,
                builder: (BuildContext context, snapshot) {
                  if ( _action == "E") {
                    _titleController.text = snapshot.data.incidentTitle.toString();
                    _descriptionController.text = snapshot.data.description.toString();
                    _addressController.text = snapshot.data.address.toString();
                  }


                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //   Icon(Icons.home_work, size: 120.0, color: Colors.lightBlue),
                      Text(
                        'Gestão de Incidentes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          maxLength: 25,
                          controller: _titleController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            //  border: const OutlineInputBorder(),
                              labelText: "Titulo do incidente",
                              labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 20.0)),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Titulo obrigatório";
                            }
                          },
                        ),
                      ),

                      TextFormField(
                        maxLength: 200,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          //  border: const OutlineInputBorder(),
                            labelText: "Descrição",
                            labelStyle: TextStyle(color: Colors.blue)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Descrição obrigatória";
                          }
                        },
                      ),

                      TextFormField(
                        maxLength: 60,
                        decoration: InputDecoration(
                          //  border: const OutlineInputBorder(),
                            labelText: "Morada",
                            labelStyle: TextStyle(color: Colors.blue)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _addressController,
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                if( _action=="N"){
                                  Incident incident = Incident();
                                  incident.incidentTitle = _titleController.text;
                                  incident.description = _descriptionController.text;
                                  incident.address = _addressController.text;
                                  var now = DateTime.now();
                                  incident.incidentDate = now
                                      .toString()
                                      .substring(0, now.toString().length - 7);
                                  incidentBloc.insertIncident(incident);
                                  _titleController.text = "";
                                  _descriptionController.text = "";
                                  _addressController.text = "";
                                }
                                if( _action=="E"){
                                  Incident incident =  snapshot.data;
                                  incident.incidentTitle = _titleController.text ;
                                  incident.description = _descriptionController.text  ;
                                  incident.address =_addressController.text  ;
                                  incidentBloc.updateIncident(incident);
                                }

                                UpdateMessage(context,  _action);
                                FocusScopeNode currentFocus = FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }
                            },
                            child: Text(
                              "Submenter",
                              style: TextStyle(color: Colors.white, fontSize: 25.0),
                            ),
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // dismiss dialog
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                            ),
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }


}
