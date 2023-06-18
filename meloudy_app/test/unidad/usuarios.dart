import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/usuarios.dart';
import 'package:provider/provider.dart';

void main() async{

  test('Los usuarios deben obtenerse y guardarse en el vector del provider', () async {
    
    final c = Usuarios();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetUsers();

    expect(c.usuarios.length, greaterThanOrEqualTo(1));
  });


  test('Se crea una lección correctamente', () async {

    final c = Usuarios();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetUsers();

    var longitudprevia = c.usuarios.length;

    var cont = [];
    cont.add("ape1");
    cont.add("ape2");

    var data = {
      "nombre": "prueba",
      "username": "prueba",
      "foto": "prueba.png",
      "apellidos": cont,
      "password":"prueba123",
      "correo":"prueba@gmail.com",
      "rol":"Admin"

    };

    await c.crearUsuario(data);

    var longitudposterior = c.usuarios.length;
    expect(longitudprevia, lessThan(longitudposterior));
  });

  test('Se modifica una lección correctamente', () async {

    final c = Usuarios();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetUsers();

    var nombreant = c.usuarios[c.usuarios.length-1].nombre;
    var usernameant = c.usuarios[c.usuarios.length-1].username;
    var fotoant = c.usuarios[c.usuarios.length-1].foto;
    var rolant = c.usuarios[c.usuarios.length-1].rol;
    var correoant = c.usuarios[c.usuarios.length-1].correo;

    print(usernameant);
    var cont = [];
    cont.add("ape1mod");
    cont.add("ape2mod");

    var data = {
      "nombre": "pruebamodificada",
      "username": "pruebamodificada",
      "foto": "pruebamodificada.png",
      "apellidos": cont,
      "password":"pruebamodificada123",
      "correo":"pruebamodificada@gmail.com",
      "rol":"Profesor"
    };

    await c.actualizarUsuario(data, c.usuarios[c.usuarios.length-1].id);

    var nombrepost = c.usuarios[c.usuarios.length-1].nombre;
    var usernamepost = c.usuarios[c.usuarios.length-1].username;
    var fotopost = c.usuarios[c.usuarios.length-1].foto;
    var rolpost = c.usuarios[c.usuarios.length-1].rol;
    var correopost = c.usuarios[c.usuarios.length-1].correo;

    print(usernamepost);

    expect(nombreant, isNot(equals(nombrepost)));
    expect(usernameant, isNot(equals(usernamepost)));
    expect(fotoant, isNot(equals(fotopost)));
    expect(rolant, isNot(equals(rolpost)));
    expect(correoant, isNot(equals(correopost)));
  });



  test('Se borra una lección correctamente', () async {

    final c = Usuarios();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetUsers();

    var longitudprevia = c.usuarios.length;

    await c.borrarUsuario(c.usuarios[c.usuarios.length-1].id);

    var longitudposterior = c.usuarios.length;
    expect(longitudprevia, greaterThan(longitudposterior));
  });
}