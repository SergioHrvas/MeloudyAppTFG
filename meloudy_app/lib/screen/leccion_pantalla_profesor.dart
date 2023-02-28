import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:meloudy_app/widget/lecciones_lista_profesor.dart';

class LeccionPantallaProfesor extends StatelessWidget {
  final lecciones = [];
  static const routeName = '/leccionPantallaProfesor';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: SingleChildScrollView(child: Text("Leccion en detalle")),
    );
  }
}
