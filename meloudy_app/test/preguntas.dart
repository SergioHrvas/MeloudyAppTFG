import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/preguntas.dart';
import 'package:meloudy_app/providers/preguntas_profesor.dart';
import 'package:provider/provider.dart';

void main() async {
  test('Las preguntas deben obtenerse y guardarse en el vector del provider',
      () async {
    final c = PreguntasProfesor();

    await c.fetchAndSetPreguntas();

    expect(c.preguntas.length, greaterThanOrEqualTo(1));
  });

  test('El indice de una pregunta en el vector de preguntas es el correcto',
      () async {
    final c = PreguntasProfesor();

    await c.fetchAndSetPreguntas();

    var indice = 0;
    var idPregunta = c.preguntas[indice].id;

    var i = c.getIndice(idPregunta);

    expect(i, equals(indice), reason: "a");
  });

  test('Se crea una pregunta correctamente', () async {
    final c = PreguntasProfesor();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetPreguntas();

    var longitudprevia = c.preguntas.length;

    var opciones = [];
    opciones.add("a");
    opciones.add("b");
    opciones.add("c");
    opciones.add("d");

    var respcorr = [];
    respcorr.add("a");
    respcorr.add("c");

    var data = {
      "cuestion": "prueba",
      "opciones": opciones,
      "respuestascorrectas": respcorr,
      "tipo": "multiple",
      "leccion": "63f94104d79a4308398b1f07"
    };

    await c.crearPregunta(data);

    var longitudposterior = c.preguntas.length;
    expect(longitudprevia, lessThan(longitudposterior));
  });

  test('Se modifica una pregunta correctamente', () async {

    final c = PreguntasProfesor();

    await c.fetchAndSetPreguntas();


    var cue_ant = c.preguntas[c.preguntas.length-1].cuestion;
    var lec_ant = c.preguntas[c.preguntas.length-1].leccion;


    var opciones = [];
    opciones.add("e");
    opciones.add("f");
    opciones.add("g");
    opciones.add("h");

    var respcorr = [];
    respcorr.add("h");

    var data = {
      "cuestion":"prueba2",
      "opciones": opciones,
      "respuestascorrectas":respcorr,
      "leccion":"64387a88b5af7c8a197a70cf"

    };

    await c.actualizarPregunta(data, c.preguntas[c.preguntas.length-1].id);


    var cue_nue = c.preguntas[c.preguntas.length-1].cuestion;
    var lec_nue = c.preguntas[c.preguntas.length-1].leccion;

    expect(lec_ant, isNot(equals(lec_nue)));
    expect(cue_ant, isNot(equals(cue_nue)));

  });


  test('Se borra una pregunta correctamente', () async {

    final c = PreguntasProfesor();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetPreguntas();

    var longitudprevia = c.preguntas.length;


    await c.borrarPregunta(c.preguntas[c.preguntas.length-1].id);

    var longitudposterior = c.preguntas.length;
    expect(longitudprevia, greaterThan(longitudposterior));
  });


}
