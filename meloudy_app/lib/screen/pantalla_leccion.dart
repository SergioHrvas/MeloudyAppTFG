import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/providers/lecciones.dart';

import '../ips.dart';
import '../modo.dart';
import '../providers/auth.dart';
import '../providers/preguntas.dart';

class LeccionPantalla extends StatelessWidget {
  static const routeName = '/leccion';
  @override
  Widget build(BuildContext context) {
    final leccionId =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    var idUsuario = Provider.of<Auth>(context, listen: false).userId;

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
            child:
                MODO.modo == 1 ? Container() : Image.network('http://${IP.ip}:5000/img/${contenido[i].texto}'),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
        ));
      } else if (contenido[i].tipo == 'titulo') {
        print(contenido[i].texto);
        contenidos.add(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 0),
            margin: EdgeInsets.only(top: 10),
            child: Text(contenido[i].texto,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))));
      } else if (contenido[i].tipo == 'subtitulo') {
        contenidos.add(Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 0),
            margin: EdgeInsets.only(top: 10),
            child: Text(contenido[i].texto,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))));
      } else {
        contenidos.add(Container(
            width: double.infinity,
            child: Text("ERROR",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))));
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        key: Key('pantallaleccion'),
          child: Column(
        children: [
          Container(
            child: Container(
              child: Text("${loadedLesson.nombre}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
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
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black),
                /*image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'http://${IP.ip}:5000/img/${loadedLesson.imagenprincipal}'),
                )*/),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(children: [...contenidos]),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                key: Key('hacertest'),
                onPressed: () {
                  var id = Provider.of<Auth>(context, listen: false).userId;
                  Provider.of<Preguntas>(context, listen: false).setIdUser(id);
                  Provider.of<Preguntas>(context, listen: false)
                      .setModo('respondiendo');
                  print(leccionId);
                  Navigator.pushReplacementNamed(context, '/pregunta',
                      arguments: leccionId);
                },
                child: Text(
                  "Hacer Test",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 20),

              child: ElevatedButton(
            child: Text("Historial",                   style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Provider.of<Lecciones>(context, listen: false)
                  .fetchAndSetTests(leccionId, idUsuario)
                  .then((resultado) {
                Navigator.pushReplacementNamed(context, '/historial-tests',
                    arguments: leccionId);
              });
            },
          ))
        ],
      )),
    );
  }
}
