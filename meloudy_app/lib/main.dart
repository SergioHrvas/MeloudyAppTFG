import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meloudy_app/leccion.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var lecciones = [
    "Introducción",
    "Figuras musicales",
    "El pentagrama",
    "Notas musicales",
    "El compás",
    "Claves musicales",
    "El piano"
  ];

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final hijos = <Widget>[];
    obtenerLecciones();
    for (var i = 0; i < lecciones.length; i++) {
      hijos.add(Leccion(lecciones[i]));
    }
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("MELOUDY")),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text("sadasdadasd"),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    title: Text("Item 1"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
                    child: Column(
              children: hijos,
            )))));
  }

  void obtenerLecciones() {
    fetchLeccion().then((value) {
      print(value.body);
      print("=================");
      var a = jsonDecode(value.body);
      for(var i = 0; i < a['usuario'].length; i++) {
        print(i.toString() + "d " + a['usuario'][i]['nombre']);
      }
    });
  }

  Future<http.Response> fetchLeccion() {
    return http.get(Uri.parse('http://10.0.2.2:5000/api/user/get-users'));
  }
}
