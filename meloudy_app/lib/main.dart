import 'package:meloudy_app/paleta.dart';
import 'package:meloudy_app/providers/logros.dart';
import 'package:meloudy_app/providers/notas.dart';
import 'package:meloudy_app/providers/opciones.dart';
import 'package:meloudy_app/providers/preguntas.dart';
import 'package:meloudy_app/providers/preguntas_profesor.dart';
import 'package:meloudy_app/providers/usuario.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:meloudy_app/providers/usuarios.dart';
import 'package:meloudy_app/screen/TestAcabadoPantalla.dart';
import 'package:meloudy_app/screen/historial_tests.dart';
import 'package:meloudy_app/screen/leccion_pantalla.dart';
import 'package:meloudy_app/screen/lecciones_pantalla.dart';
import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pantalla_login.dart';
import 'package:meloudy_app/providers/auth.dart';
import 'package:meloudy_app/screen/lecciones_pantalla_profesor.dart';
import 'package:meloudy_app/screen/pantalla_crear_leccion_profesor.dart';
import 'package:meloudy_app/screen/pantalla_crear_logro_profesor.dart';
import 'package:meloudy_app/screen/pantalla_crear_pregunta_profesor.dart';
import 'package:meloudy_app/screen/pantalla_crear_usuario_profesor.dart';
import 'package:meloudy_app/screen/pantalla_editar_leccion_profesor.dart';
import 'package:meloudy_app/screen/pantalla_editar_logro_profesor.dart';
import 'package:meloudy_app/screen/pantalla_editar_pregunta_profesor.dart';
import 'package:meloudy_app/screen/pantalla_editar_usuario.dart';
import 'package:meloudy_app/screen/pantalla_editar_usuario_profesor.dart';
import 'package:meloudy_app/screen/pantalla_logro.dart';
import 'package:meloudy_app/screen/pantalla_logros.dart';
import 'package:meloudy_app/screen/pantalla_logros_profesor.dart';
import 'package:meloudy_app/screen/pantalla_preguntas_profesor.dart';
import 'package:meloudy_app/screen/pantalla_usuario.dart';
import 'package:meloudy_app/screen/pantalla_usuarios_profesor.dart';
import 'package:meloudy_app/screen/pantalla_pregunta.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:meloudy_app/screen/pantalla_cargando.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';

import 'modo.dart';
void main() {
  MODO.modo = 0;
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
            create: (_) => Lecciones(),
            update: (ctx, auth, leccionesAnteriores) =>
            leccionesAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, Usuarios>(
            create: (_) => Usuarios(),
            update: (ctx, auth, usuariosAnteriores) =>
            usuariosAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, Preguntas>(
            create: (_) => Preguntas(),
            update: (ctx, auth, preguntasAnteriores) =>
            preguntasAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, PreguntasProfesor>(
            create: (_) => PreguntasProfesor(),
            update: (ctx, auth, preguntasAnteriores) =>
            preguntasAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, Opciones>(
            create: (_) => Opciones(),
            update: (ctx, auth, opcionesAnteriores) =>
            opcionesAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, Notas>(
            update: (ctx, auth, notasanteriores, ) =>
                Notas(notasanteriores == null ? [] : notasanteriores.items)),
        ChangeNotifierProxyProvider<Auth, UsuarioPerfil>(
            update: (ctx, auth, userant, ) =>
                UsuarioPerfil(auth.token, userant == null ? Usuario() : userant.item)),
        ChangeNotifierProxyProvider<Auth, Logros>(
            create: (_) => Logros(),
            update: (ctx, auth, logrosAnteriores) =>
            logrosAnteriores..update(auth.token)
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Meloudy',
          theme: ThemeData(
            scaffoldBackgroundColor: Paleta.blueBackground,
            primarySwatch: Paleta.blueCustom,
          ),
          home: /*LeccionesPantalla()*/
              auth.isAuth
              ? LeccionesPantalla() : MODO.modo == 0 ? FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting ? PantallaCargando() : PantallaLogin(),
          ) : PantallaLogin(),
          routes: {
            LeccionPantalla.routeName: (ctx) => LeccionPantalla(),
            LeccionesPantallaProfesor.routeName: (ctx) => LeccionesPantallaProfesor(),
            PantallaDashboard.routeName: (ctx) => PantallaDashboard(),
            PreguntaPantalla.routeName: (ctx) => PreguntaPantalla(),
            TestAcabadoPantalla.routeName: (ctx) => TestAcabadoPantalla(),
            HistorialTests.routeName: (ctx) => HistorialTests(),
            PantallaPreguntasProfesor.routeName: (ctx) => PantallaPreguntasProfesor(),
            PantallaCrearPreguntaProfesor.routeName: (ctx) => PantallaCrearPreguntaProfesor(),
            PantallaCrearLeccionProfesor.routeName: (ctx) => PantallaCrearLeccionProfesor(),
            PantallaEditarLeccionProfesor.routeName: (ctx) => PantallaEditarLeccionProfesor(),
            PantallaUsuariosProfesor.routeName: (ctx) => PantallaUsuariosProfesor(),
            PantallaEditarPreguntaProfesor.routeName: (ctx) => PantallaEditarPreguntaProfesor(),
            PantallaCrearUsuarioProfesor.routeName: (ctx) => PantallaCrearUsuarioProfesor(),
            PantallaEditarUsuarioProfesor.routeName: (ctx) => PantallaEditarUsuarioProfesor(),
            PantallaEditarUsuario.routeName: (ctx) => PantallaEditarUsuario(),
            PantallaUsuario.routeName: (ctx) => PantallaUsuario(),
            PantallaLogrosProfesor.routeName: (ctx) => PantallaLogrosProfesor(),
            PantallaLogros.routeName: (ctx) => PantallaLogros(),
            PantallaCrearLogroProfesor.routeName: (ctx) => PantallaCrearLogroProfesor(),
            PantallaEditarLogroProfesor.routeName: (ctx) => PantallaEditarLogroProfesor(),
            PantallaLogro.routeName: (ctx) => PantallaLogro(),


          },
        ),
      ),
    );
  }
}
