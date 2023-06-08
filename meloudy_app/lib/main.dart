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
import 'package:meloudy_app/login.dart';
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
            update: (ctx, auth, preguntasAnteriores) =>
              Preguntas(auth.token, preguntasAnteriores == null ? [] : preguntasAnteriores.items)),
        ChangeNotifierProxyProvider<Auth, PreguntasProfesor>(
            create: (_) => PreguntasProfesor(),
            update: (ctx, auth, usuariosAnteriores) =>
            usuariosAnteriores..update(auth.token)
        ),
        ChangeNotifierProxyProvider<Auth, Opciones>(
            update: (ctx, auth, opcionesanteriores,) =>
                Opciones(opcionesanteriores == null ? [] : opcionesanteriores.items)),
        ChangeNotifierProxyProvider<Auth, Notas>(
            update: (ctx, auth, notasanteriores, ) =>
                Notas(notasanteriores == null ? [] : notasanteriores.items)),
        ChangeNotifierProxyProvider<Auth, UsuarioPerfil>(
            update: (ctx, auth, userant, ) =>
                UsuarioPerfil(auth.token, userant == null ? Usuario() : userant.item)),
        ChangeNotifierProxyProvider<Auth, Logros>(
            update: (ctx, auth, logrosanteriores, ) =>
                Logros(auth.token, logrosanteriores == null ? [] : logrosanteriores.items))
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Meloudy',
          theme: ThemeData(
            scaffoldBackgroundColor: Paleta.blueBackground,
            primarySwatch: Paleta.blueCustom,
          ),
          //home: MicrofonoPantalla(),
          home: auth.isAuth
              ? LeccionesPantalla() : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting ? PantallaCargando() : Login(),
          ),
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
