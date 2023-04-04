import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/preguntas_profesor.dart';
import '../widget/drawer_app.dart';

class PantallaCrearPreguntaProfesor extends StatefulWidget {
  static const routeName = '/crearpregunta';

  @override
  _PantallaCrearPreguntaProfesorState createState() =>
      _PantallaCrearPreguntaProfesorState();
}

class _PantallaCrearPreguntaProfesorState extends State<PantallaCrearPreguntaProfesor> {
  _PantallaCrearPreguntaProfesorState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Image.asset('assets/musica.png')

              ),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text("sdd"),

              ),
      ]
      ),
        ),
      ),
    );
  }
}
