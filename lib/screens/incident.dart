import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projeto_cm/bloc/incident.dart';
import 'package:projeto_cm/models/incident.dart';
import 'package:projeto_cm/widgets/update_message.dart';
import 'dart:io';

class IncidentScreen extends StatelessWidget {
  IncidentScreen(this._action, {String this.incidentKey});

  final String _action;
  final incidentKey;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKeyValidator = GlobalKey<FormState>();
  final incidentBloc = IncidentBloc();
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_action == "E") {
      incidentBloc.loadIncident(incidentKey);
    }
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
      child: Form(
        key: _formKeyValidator,
        child: StreamBuilder(
            initialData: null,
            stream: incidentBloc.output,
            builder: (BuildContext context, snapshot) {
              if (_action == "E") {
                _titleController.text = snapshot.data.title.toString();
                _descriptionController.text =
                    snapshot.data.description.toString();
                _addressController.text = snapshot.data.address.toString();
                _image = snapshot.data.image;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Gestão de Incidentes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
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
                          labelText: "Titulo",
                          labelStyle: TextStyle(
                              color: Colors.blueGrey, fontSize: 20.0)),
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
                        labelText: "Descrição",
                        labelStyle: TextStyle(color: Colors.blueGrey)),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Descrição obrigatória";
                      }
                      if (value.length < 100) {
                        return "Descrição têm de ter no mínimo 100 carateres";
                      }
                    },
                  ),
                  TextFormField(
                    maxLength: 60,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: "Morada (Opcional)",
                        labelStyle: TextStyle(color: Colors.blueGrey)),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    controller: _addressController,
                  ),
                  RaisedButton.icon(
                      onPressed: _getImage,
                      color: Colors.blueGrey,
                      icon: Icon(Icons.add_a_photo, color: Colors.white),
                      label: Text(
                        'Foto',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKeyValidator.currentState.validate()) {
                            if (_action == "N") {
                              Incident incident = Incident();
                              incident.title = _titleController.text;
                              incident.description =
                                  _descriptionController.text;
                              incident.address = _addressController.text;
                              incident.image = _image;
                              final now = DateTime.now();
                              final DateFormat dateFormat =
                                  DateFormat("dd/MM/yyyy - HH:mm");
                              incident.incidentDate =
                                  dateFormat.format(now).toString();
                              incidentBloc.insertIncident(incident);
                              _titleController.text = "";
                              _descriptionController.text = "";
                              _addressController.text = "";
                            }
                            if (_action == "E") {
                              Incident incident = snapshot.data;
                              incident.title = _titleController.text;
                              incident.description =
                                  _descriptionController.text;
                              incident.address = _addressController.text;
                              incident.image = _image;
                              incidentBloc.updateIncident(incident);
                            }

                            UpdateMessage(context, _action);
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }
                        },
                        child: Text(
                          "Submenter",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blueGrey,
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
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 25.0),
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
