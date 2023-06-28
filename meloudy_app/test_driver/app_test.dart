// Importa la Flutter Driver API
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:meloudy_app/modo.dart';
import 'package:test/test.dart';

void main() {
  group('Meloudy', () {
    FlutterDriver driver;

    MODO.modo = 0;
    // Conéctate al driver de Flutter antes de ejecutar cualquier test
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Cierra la conexión con el driver después de que se hayan completado los tests
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Creación de usuario', () async {
      await driver.clearTimeline();
      MODO.modo = 0;

      final botonCorreo = find.byValueKey('correo');
      driver.waitFor(botonCorreo);
      driver.tap(botonCorreo);
      driver.enterText('profe@correo');

      driver.tap(find.byValueKey('password'));
      driver.enterText('profe');

      final botonIniciarSesion = find.byValueKey('boton1');
      driver.tap(botonIniciarSesion);

      final textoTitulo = find.byValueKey('titulo');
      driver.waitFor(textoTitulo);
      expect(await driver.getText(textoTitulo), "MELOUDY");

      //Abro el drawer
      final SerializableFinder drawerOpenButton =
          find.byTooltip('Open navigation menu');
      driver.waitFor(drawerOpenButton);
      await driver.tap(drawerOpenButton);
      final botonDashboard = find.byValueKey('dashboard');

      driver.waitFor(botonDashboard);

      await driver.tap(botonDashboard);

      final listaUsuarios = find.byValueKey('usuarios');
      driver.waitFor(listaUsuarios);

      expect(await driver.getText(listaUsuarios), "Usuarios");

      await driver.tap(listaUsuarios);
      final botonCrear = find.byValueKey('crearUsuario');
      driver.waitFor(botonCrear);

      await driver.tap(botonCrear);

      final nombreUsuario = find.byValueKey('nombreUsuario');
      driver.waitFor(nombreUsuario);

      await driver.tap(nombreUsuario);
      driver.enterText('NombrePrueba');

      final apellido1Usuario = find.byValueKey('apellido1Usuario');

      await driver.tap(apellido1Usuario);
      await driver.enterText('Apellido1');

      final apellido2Usuario = find.byValueKey('apellido2Usuario');

      await driver.tap(apellido2Usuario);
      await driver.enterText('Apellido2');

      final userName = find.byValueKey('userName');

      await driver.tap(userName);
      await driver.enterText('usuarioprueba123');

      final correoUsuario = find.byValueKey('correoUsuario');

      await driver.tap(correoUsuario);
      await driver.enterText('Correo');

      final passwordUsuario = find.byValueKey('passwordUsuario');

      await driver.tap(passwordUsuario);
      await driver.enterText('password');

      final botonCrearUser = find.byValueKey('botonCrear');
      await driver.tap(botonCrearUser);

      final botonUser = find.byValueKey('Correo');

      driver.waitFor(botonUser);

      expect(await driver.getText(botonUser), "Correo");
    }, timeout: Timeout(Duration(minutes: 2)));

    test('Modificación del perfil', () async {
      await driver.clearTimeline();
      MODO.modo = 0;

      final SerializableFinder drawerOpenButton =
          find.byTooltip('Open navigation menu');

      // Open the drawer
      driver.waitFor(drawerOpenButton);
      await driver.tap(drawerOpenButton);

      final botonDashboard = find.byValueKey('perfil');

      driver.waitFor(botonDashboard);

      await driver.tap(botonDashboard);

      final botonEditarPerfil = find.byValueKey('editarperfil');
      driver.waitFor(botonEditarPerfil);

      await driver.tap(botonEditarPerfil);

      final userName = find.byValueKey('userName');
      driver.waitFor(userName);

      await driver.tap(userName);
      await driver.enterText('LuisLopezE');

      final pantallaEditarUser = find.byValueKey('pantallaEditarUser');
      await driver.scroll(pantallaEditarUser, 0, -1400, Duration(seconds: 5));

      final botonEditarUser = find.byValueKey('modificar');
      await driver.tap(botonEditarUser);

      final usuarioUsername = find.byValueKey('userNameFinal');

      driver.waitFor(usuarioUsername);

      expect(await driver.getText(usuarioUsername), "@LuisLopezE");
    }, timeout: Timeout(Duration(minutes: 2)));

    test('Realización de un test', () async {
      await driver.clearTimeline();
      MODO.modo = 0;

      final SerializableFinder drawerOpenButton =
          find.byTooltip('Open navigation menu');

      // Open the drawer
      driver.waitFor(drawerOpenButton);

      await driver.tap(drawerOpenButton);
      final botonInicio = find.byValueKey('inicio');

      driver.waitFor(botonInicio);
      await driver.tap(botonInicio);

      final botonLeccion = find.byValueKey('entrarIntroducción');
      driver.waitFor(botonLeccion);
      sleep(Duration(seconds: 4));

      await driver.tap(botonLeccion);

      final botonEmpezar = find.byValueKey('hacertest');
      final pantallaleccion = find.byValueKey('pantallaleccion');
      sleep(Duration(seconds: 4));

      await driver.scroll(pantallaleccion, 0, -1400, Duration(seconds: 5));

      driver.waitFor(botonEmpezar);

      await driver.tap(botonEmpezar);

      for (var i = 0; i < 10; i++) {
        final preguntaTipo = find.byValueKey('preguntatipo');
        driver.waitFor(preguntaTipo);

        final tipo = await driver.getText(preguntaTipo);

        if (tipo == 'texto') {
          final campoTexto = find.byValueKey('texto');
          await driver.tap(campoTexto);
          await driver.enterText('melodía');
        } else if (tipo == 'unica') {
          final opcion = find.byValueKey('opcion1');
          await driver.tap(opcion);
        } else if (tipo == 'multiple') {
          final opcion = find.byValueKey('opcion1');
          await driver.tap(opcion);
          final opcion_dos = find.byValueKey('opcion2');
          await driver.tap(opcion_dos);
        }

        if (i < 9) {
          final siguiente = find.byValueKey('siguiente');
          await driver.tap(siguiente);
        } else {
          final fin = find.byValueKey('fin');
          await driver.tap(fin);
        }
      }

      final revisarTest = find.byValueKey('revisar');
      driver.waitFor(revisarTest);
      expect(await driver.getText(revisarTest), "Revisar");

    }, timeout: Timeout(Duration(minutes: 2)));
  });
}
