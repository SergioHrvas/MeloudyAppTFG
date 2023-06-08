import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:provider/provider.dart';

void main() async{    final c = Lecciones();
  
  test('Las lecciones deben obtenerse y guardarse en el vector del provider', () async {
    
    final c = Lecciones();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetLecciones(id);

    expect(c.lecciones.length, greaterThanOrEqualTo(1));
  });

  test('El indice de una leccion en el vector de lecciones es el correcto', () async {
    final c = Lecciones();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetLecciones(id);

    var indice = 0;
    var idLeccion = c.lecciones[indice].id;

    var i = c.getIndice(idLeccion);

    expect(i, equals(indice), reason: "a");

  });

  test('El número de tests aprobados de una lección es correcto', () async {

    final c = Lecciones();
    var id = "63fe53c56ac25d3aa7ac988b";

    await c.fetchAndSetLecciones(id);

    var indice = '63f94104d79a4308398b1f07';

    var data = [];
    data.add({
      'idLeccion': '63f94104d79a4308398b1f07',
      'testsAprobados': 5
    });
    data.add({
      'idLeccion': '4343234242424234234242',
      'testsAprobados': 20
    });
    data.add({
      'idLeccion': '6462a2a0225c93f0488842c4',
      'testsAprobados': 2
    });
    var i = c.buscarNumAprobados(data, indice);

    expect(i, isNot(equals(-1)));
  });


test('Se crea una lección correctamente', () async {

  final c = Lecciones();
  var id = "63fe53c56ac25d3aa7ac988b";
  await c.fetchAndSetLecciones(id);

  var longitudprevia = c.lecciones.length;

  var cont = [];

  cont.add({"tipo":"titulo", "texto":"a"});
  cont.add({"tipo":"imagen", "texto":"b"});
  cont.add({"tipo":"texto", "texto":"c"});
  cont.add({"tipo":"titulo", "texto":"d"});
  cont.add({"tipo":"texto", "texto":"e"});
  var data = {
    "nombre": "prueba",
    "imagenprincipal": "prueba.png",
    "contenido": cont,
  };


  await c.crearLeccion(data);

  var longitudposterior = c.lecciones.length;
  expect(longitudprevia, lessThan(longitudposterior));
});

test('Se modifica una lección correctamente', () async {

  final c = Lecciones();
  var id = "63fe53c56ac25d3aa7ac988b";
  await c.fetchAndSetLecciones(id);

  var nom_ant = c.lecciones[c.lecciones.length-1].nombre;
  var ima_ant = c.lecciones[c.lecciones.length-1].imagenprincipal;

  var cont = [];
  cont.add({"tipo":"titulo", "texto":"ad"});
  cont.add({"tipo":"imagen", "texto":"bd"});
  cont.add({"tipo":"texto", "texto":"cd"});
  cont.add({"tipo":"titulo", "texto":"dd"});
  cont.add({"tipo":"texto", "texto":"ed"});

  var data = {
    "nombre": "pruebamodfificada",
    "imagenprincipal": "pruebamod.png",
    "contenido": cont,
  };

  await c.modificarLeccion(data, c.lecciones[c.lecciones.length-1].id);


  var nom_nue = c.lecciones[c.lecciones.length-1].nombre;
  var ima_nue = c.lecciones[c.lecciones.length-1].imagenprincipal;

  expect(nom_ant, isNot(equals(nom_nue)));
  expect(ima_ant, isNot(equals(ima_nue)));

});


test('Se borra una lección correctamente', () async {

  final c = Lecciones();
  var id = "63fe53c56ac25d3aa7ac988b";
  await c.fetchAndSetLecciones(id);

  var longitudprevia = c.lecciones.length;


  await c.borrarLeccion(c.lecciones[c.lecciones.length-1].id);

  var longitudposterior = c.lecciones.length;
  expect(longitudprevia, greaterThan(longitudposterior));
});


}