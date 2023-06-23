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

    test('starts at 0', () async {
      await driver.clearTimeline();
      // Usa el método `driver.getText` para verificar que el contador comience en 0.
      final botonIniciarSesion = find.byValueKey('boton1');
      final textoTitulo = find.byValueKey('titulo');
      final botonCorreo = find.byValueKey('correo');
      final botonPassword = find.byValueKey('password');

      driver.waitFor(botonCorreo);
      driver.tap(botonCorreo);
      driver.enterText('profe@correo');


      driver.tap(find.byValueKey('password'));
      driver.enterText('profe');

      driver.tap(botonIniciarSesion);
      driver.waitFor(textoTitulo);

      expect(await driver.getText(textoTitulo), "MELOUDY");

    },timeout: Timeout(Duration(minutes: 2)));


  });
}
