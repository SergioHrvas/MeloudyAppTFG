import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/providers/lecciones.dart';

import '../providers/auth.dart';
import '../providers/preguntas.dart';

class LeccionPantalla extends StatelessWidget {
  static const routeName = '/leccion';
  @override
  Widget build(BuildContext context) {
    final leccionId =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    final loadedLesson = Provider.of<Lecciones>(
      context,
      listen: false,
    ).findById(leccionId);
    final contenido = loadedLesson.contenido;
    var contenidos = List<Widget>();
    for (var i = 0; i < contenido.length; i++) {
      if (contenido[i].tipo == 'texto') {
        contenidos.add(Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
            child: Text(contenido[i].texto)));
      } else if (contenido[i].tipo == 'img') {
        contenidos.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
            child: Image.asset('assets/${contenido[i].texto}'),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
        ));
      } else if (contenido[i].tipo == 'titulo') {
        contenidos.add(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 0),
            margin: EdgeInsets.only(top: 10),
            child: Text(contenido[i].texto,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))));
      }
      print(contenidos.length);
    }

    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Container(
              child: Text("${loadedLesson.nombre}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              width: 170,
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
            ),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
          ),
          Container(
            height: 130,
            width: 130,
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset('assets/musica.png'),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(children: [...contenidos]),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(onPressed: (
                  ){
                var id = Provider.of<Auth>(context,listen:false).userId;
                Provider.of<Preguntas>(context, listen:false).setIdLeccion(leccionId);
                Provider.of<Preguntas>(context, listen:false).setIdUser(id);
                Provider.of<Preguntas>(context, listen:false).setModo('respondiendo');
                Navigator.pushReplacementNamed(context, '/pregunta', arguments: leccionId);
              }, child: Text("Hacer Test", style: TextStyle(fontSize: 20),),))
        ],
      )),
    );
  }
}
