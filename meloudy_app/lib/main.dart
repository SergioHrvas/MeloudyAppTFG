import 'package:flutter/material.dart';
import 'package:meloudy_app/leccion.dart';
import 'package:flutter/widgets.dart';

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
    for (var i = 0; i < lecciones.length; i++) {
      hijos.add(Leccion(lecciones[i]));
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("MELOUDY")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(child: Text("sadasdadasd"),
              decoration: BoxDecoration(color: Colors.blue),),
              ListTile(title: Text("Item 1"), onTap: () {
                Navigator.pop(context);
              },),
              ListTile(title: Text("Item 2"),
              onTap: (){
                Navigator.pop(context);
              },)
            ],
          ),
        ),
        body: SingleChildScrollView(
                  child: Container(
                      child: Column(
                children: hijos,
              )))
    ));
  }
}
