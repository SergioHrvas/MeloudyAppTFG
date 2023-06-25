// Importa la Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Meloudy', () {
    // Primero, define los Finders. Podemos usarlos para localizar Widgets desde
    // la suite de test. Nota: los Strings proporcionados al método `byValueKey`
    // deben ser los mismos que los Strings utilizados para las Keys del paso 1.



    FlutterDriver driver;

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
      // Usa el método `driver.getText` para verificar que el contador comience en 0.
      final botonIniciarSesion = find.byValueKey('boton1');
      final textoTitulo = find.byValueKey('titulo');
      final botonCorreo = find.byValueKey('correo');
      final botonPassword = find.byValueKey('password');
      final drawer = find.byValueKey('drawer');

      driver.waitFor(botonCorreo);
      driver.tap(botonCorreo);
      driver.enterText('profe@correo');


      driver.tap(find.byValueKey('password'));
      driver.enterText('profe');

      driver.tap(botonIniciarSesion);
      driver.waitFor(textoTitulo);

      expect(await driver.getText(textoTitulo), "MELOUDY");

      final SerializableFinder drawerOpenButton = find.byTooltip('Open navigation menu');

      // Open the drawer
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


    },timeout: Timeout(Duration(minutes: 2)));



    test('Modificación del perfil', () async {
      await driver.clearTimeline();
      // Usa el método `driver.getText` para verificar que el contador comience en 0.
     /* final botonIniciarSesion = find.byValueKey('boton1');
      final textoTitulo = find.byValueKey('titulo');
      final botonCorreo = find.byValueKey('correo');
      final botonPassword = find.byValueKey('password');
      final drawer = find.byValueKey('drawer');

      driver.waitFor(botonCorreo);
      driver.tap(botonCorreo);
      driver.enterText('profe@correo');


      driver.tap(find.byValueKey('password'));
      driver.enterText('profe');

      driver.tap(botonIniciarSesion);
      driver.waitFor(textoTitulo);

      expect(await driver.getText(textoTitulo), "MELOUDY");*/

      final SerializableFinder drawerOpenButton = find.byTooltip('Open navigation menu');

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

      final botonEditarUser = find.byValueKey('modificar');
      await driver.tap(botonEditarUser);

      final usuarioUsername = find.byValueKey('userNameFinal');

      driver.waitFor(usuarioUsername);
      expect(await driver.getText(usuarioUsername), "@LuisLopezE");


    },timeout: Timeout(Duration(minutes: 2)));

  });
}
