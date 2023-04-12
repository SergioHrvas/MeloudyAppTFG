import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:meloudy_app/widget/lecciones_lista_profesor.dart';

class LeccionesPantallaProfesor extends StatelessWidget {
  final lecciones = [];
  static const routeName = '/leccionesPantallaProfesor';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child:
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/crearleccion');
                }, child: Text("Crear Lección"))),
        LeccionesListaProfesor()
      ])),
    );
  }
}
