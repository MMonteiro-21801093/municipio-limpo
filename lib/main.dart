import 'package:flutter/material.dart';
import 'package:projeto_cm/screens/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Município Limpo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen( title:'Município Limpo'),
    );
  }
}


