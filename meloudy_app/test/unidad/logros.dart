import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/logros.dart';
import 'package:provider/provider.dart';

void main() async {
  test('Los logros deben obtenerse y guardarse en el vector del provider',
      () async {
    final c = Logros();

    await c.fetchAndSetLogros();

    expect(c.logros.length, greaterThanOrEqualTo(1));
  });

  test('El indice de una pregunta en el vector de preguntas es el correcto',
      () async {
    final c = Logros();

    await c.fetchAndSetLogros();

    var indice = 0;
    var idPregunta = c.logros[indice].id;

    var i = c.getIndice(idPregunta);

    expect(i, equals(indice));
  });

  test('Se crea un logro correctamente', () async {
    final c = Logros();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetLogros();

    var longitudprevia = c.logros.length;

    var data = {
      "nombre": "prueba",
      "descripcion": "prueba",
      "imagen": "prueba.png",
      "tipo":"lecciones",
      "condicion":3
    };

    await c.crearLogro(data);

    var longitudposterior = c.logros.length;
    expect(longitudprevia, lessThan(longitudposterior));
  });

  test('Se modifica un logro correctamente', () async {

    final c = Logros();

    await c.fetchAndSetLogros();


    var nom_ant = c.logros[c.logros.length-1].nombre;
    var des_ant = c.logros[c.logros.length-1].descripcion;
    var ima_ant = c.logros[c.logros.length-1].imagen;
    var con_ant = c.logros[c.logros.length-1].condicion;
    var tip_ant = c.logros[c.logros.length-1].tipo;


    var data = {
      "nombre": "pruebamod",
      "descripcion": "pruebamod",
      "imagen": "pruebamod.png",
      "tipo":"preguntas",
      "condicion":8

    };

    await c.editarLogro(data, c.logros[c.logros.length-1].id);


    var nom_nue = c.logros[c.logros.length-1].nombre;
    var des_nue = c.logros[c.logros.length-1].descripcion;
    var ima_nue = c.logros[c.logros.length-1].imagen;
    var con_nue = c.logros[c.logros.length-1].condicion;
    var tip_nue = c.logros[c.logros.length-1].tipo;

    expect(nom_ant, isNot(equals(nom_nue)));
    expect(des_ant, isNot(equals(des_nue)));
    expect(ima_ant, isNot(equals(ima_nue)));
    expect(tip_ant, isNot(equals(tip_nue)));
    expect(con_ant, isNot(equals(con_nue)));


  });

  test('Se borra un logro correctamente', () async {

    final c = Logros();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetLogros();

    var longitudprevia = c.logros.length;


    await c.borrarLogro(c.logros[c.logros.length-1].id);

    var longitudposterior = c.logros.length;
    expect(longitudprevia, greaterThan(longitudposterior));
  });



}

