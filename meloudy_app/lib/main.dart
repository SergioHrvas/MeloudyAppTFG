import 'package:meloudy_app/providers/preguntas.dart';
import 'package:meloudy_app/screen/TestAcabadoPantalla.dart';
import 'package:meloudy_app/screen/historial_tests.dart';
import 'package:meloudy_app/screen/leccion_pantalla.dart';
import 'package:meloudy_app/screen/lecciones_pantalla.dart';
import 'package:flutter/material.dart';
import 'package:meloudy_app/login.dart';
import 'package:meloudy_app/providers/auth.dart';
import 'package:meloudy_app/screen/lecciones_pantalla_profesor.dart';
import 'package:meloudy_app/screen/leccion_pantalla_profesor.dart';
import 'package:meloudy_app/screen/microfono_pantalla.dar.dart';
import 'package:meloudy_app/screen/pregunta_pantalla.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:meloudy_app/screen/pantalla_cargando.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Lecciones>(
            update: (ctx, auth, leccionesAnteriores) =>
                Lecciones(auth.token, leccionesAnteriores == null ? [] : leccionesAnteriores.items)),
        ChangeNotifierProxyProvider<Auth, Preguntas>(
            update: (ctx, auth, preguntasAnteriores) =>
              Preguntas(auth.token, preguntasAnteriores == null ? [] : preguntasAnteriores.items))
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Meloudy',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          /*home: MicrofonoPantalla()*/
          home: auth.isAuth
              ? LeccionesPantalla() : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting ? PantallaCargando() : Login(),
          ),
          routes: {
            LeccionPantalla.routeName: (ctx) => LeccionPantalla(),
            LeccionesPantallaProfesor.routeName: (ctx) => LeccionesPantallaProfesor(),
            LeccionPantallaProfesor.routeName: (ctx) => LeccionPantallaProfesor(),
            PantallaDashboard.routeName: (ctx) => PantallaDashboard(),
            PreguntaPantalla.routeName: (ctx) => PreguntaPantalla(),
            TestAcabadoPantalla.routeName: (ctx) => TestAcabadoPantalla(),
            HistorialTests.routeName: (ctx) => HistorialTests(),



          },
        ),
      ),
    );
  }
}
