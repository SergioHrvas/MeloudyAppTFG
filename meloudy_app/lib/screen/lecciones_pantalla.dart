import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/lecciones_lista.dart';
import 'package:meloudy_app/widget/drawer_app.dart';

class LeccionesPantalla extends StatelessWidget {
  final lecciones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: SingleChildScrollView(child: LeccionesLista()),
    );
  }
}
