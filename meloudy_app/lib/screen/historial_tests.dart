import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pantalla_pregunta.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/lecciones.dart';
import '../providers/preguntas.dart';
import '../widget/drawer_app.dart';

String parsearFecha(fecha) {
  var fechaparseada;

  fechaparseada = fecha.toString().substring(8, 10) +
      "/" +
      fecha.toString().substring(5, 7) +
      "/" +
      fecha.toString().substring(0, 4);

  return fechaparseada;
}

class HistorialTests extends StatelessWidget {
  static const routeName = '/historial-tests';

  Widget build(BuildContext context) {
    var leccionid =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    var tests = Provider.of<Lecciones>(context, listen: false)
        .findById(leccionid)
        .tests;

    List<Widget> lista = [];

    for (var i = 0; i < tests.length; i++) {
      var fecha = parsearFecha(tests[i].fecha_creacion);
      print(fecha);
      lista.add(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
          decoration: BoxDecoration(
              color: Colors.white70,border: Border.all(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${tests[i].aciertos}/10",
              style: TextStyle(
                  fontSize: 30,
                  color: tests[i].aciertos < 5 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${fecha}",
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<Preguntas>(context, listen: false)
                      .vaciarPreguntas();

                  Provider.of<Preguntas>(context, listen: false)
                      .setPreguntas(tests[i].id)
                      .then((resultado) {
                    Provider.of<Preguntas>(context, listen: false)
                        .setModo('revisando');
                    Navigator.pushNamed(context, PreguntaPantalla.routeName);
                  });
                },
                child: Text("Revisar", style: TextStyle(fontSize: 20),))
          ])));
    }

    return Scaffold(
        appBar: AppBar(title: Text("MELOUDY")),
        drawer: DrawerApp(),
        body: SingleChildScrollView(
            child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lista,
          ),
        )));
  }
}
