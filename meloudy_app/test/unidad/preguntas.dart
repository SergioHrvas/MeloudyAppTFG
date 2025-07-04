import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/opciones.dart';
import 'package:meloudy_app/providers/preguntas.dart';
import 'package:meloudy_app/providers/preguntas_profesor.dart';
import 'package:provider/provider.dart';

void main() async {
  test('Las preguntas del profesor deben obtenerse y guardarse en el vector del provider PreguntasProfesor',
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

  test('Las preguntas deben obtenerse y guardarse en el vector del provider Preguntas',
          () async {
        final c = Preguntas();

        var leccion = '63f94104d79a4308398b1f07';

        await c.fetchAndSetPreguntas(leccion);

        expect(c.preguntas.length, greaterThanOrEqualTo(1));
      });


  test('Las opciones de las preguntas asignan el valor correctamente',
          () async {
        final c = Opciones();

        c.opciones.add(true);
        c.opcionesTexto.add('prueba');
        c.opciones.add(false);
        c.opcionesTexto.add('prueba2');
        c.opciones.add(false);
        c.opcionesTexto.add('prueba3');
        c.opciones.add(false);
        c.opcionesTexto.add('prueba4');

        await c.setValor(2, 'unica');


        expect(c.opciones[0], equals(false));
        expect(c.opciones[1], equals(false));
        expect(c.opciones[2], equals(true));
        expect(c.opciones[3], equals(false));
      });

  test('Las respuestas de las preguntas asignan el valor correctamente',
          () async {
            final c = Preguntas();
            var leccion = '63f94104d79a4308398b1f07';

           await c.fetchAndSetPreguntas(leccion);

        c.setRespuestas("prueba1");
        c.siguientePregunta();
        c.setRespuestas("prueba2");

        var primeraresp = c.preguntas[0].respuestas.length;
        var segundaresp = c.preguntas[1].respuestas.length;

        expect(primeraresp, greaterThanOrEqualTo(1));
            expect(segundaresp, greaterThanOrEqualTo(1));

      });

  test('El estado pulsado de las respuestas se asigna correctamente',
          () async {
        final c = Preguntas();
        var leccion = '63f94104d79a4308398b1f07';

        await c.fetchAndSetPreguntas(leccion);
        var pulsadoant;
        var pulsadodes;

        var sigo;
        sigo = (c.preguntas[c.indice].tipo != 'multiple' && c.preguntas[c.indice].tipo != 'unica') ? true : false;

        do {

          pulsadoant = c.preguntas[0].pulsado[2];
          c.setPulsado(2);

          var pulsadodes = c.preguntas[0].pulsado[2];
          c.siguientePregunta();
          sigo = (c.preguntas[c.indice].tipo != 'multiple' && c.preguntas[c.indice].tipo != 'unica') ? true : false;
        }while(sigo);

          expect(pulsadoant, isNot(equals(pulsadodes)));
        });


}

