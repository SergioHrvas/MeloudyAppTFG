// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'package:meloudy_app/paleta.dart';
import 'package:meloudy_app/providers/auth.dart';
import 'package:meloudy_app/providers/logros.dart';
import 'package:meloudy_app/providers/preguntas.dart';
import 'package:meloudy_app/providers/preguntas_profesor.dart';
import 'package:meloudy_app/providers/usuario.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:meloudy_app/providers/usuarios.dart';
import 'package:meloudy_app/screen/pantalla_leccion.dart';
import 'package:meloudy_app/screen/pantalla_lecciones_profesor.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';
import 'package:meloudy_app/screen/pantalla_logros_profesor.dart';
import 'package:meloudy_app/screen/pantalla_preguntas_profesor.dart';
import 'package:meloudy_app/screen/pantalla_usuario.dart';
import 'package:meloudy_app/screen/pantalla_usuarios_profesor.dart';
import 'package:meloudy_app/sesion.dart';
import 'package:meloudy_app/widget/dashboard.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/ips.dart';

import 'package:meloudy_app/main.dart';
import 'package:meloudy_app/modo.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:meloudy_app/screen/pantalla_lecciones.dart';
import 'package:meloudy_app/screen/pantalla_login.dart';
import 'package:meloudy_app/widget/tarjeta_login.dart';
import 'package:nock/nock.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  setUpAll(nock.init);
  setUp(() {
    nock.cleanAll();
  });

  MODO.modo = 1;

  testWidgets('El botón de Iniciar sesión funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000').post('/api/user/login', {
          'correo': 'profe@correo',
          'password': 'profe'
        }).reply(200,
            '{"status":"success","usuario":{"_id":"63fe53c56ac25d3aa7ac988b","nombre":"Luis","password":"2b10BZE7YIw2Ia41jB3sP7xcCeII6K27zWOo6tP5LT9V6Gfix8jGqU6KW","apellidos":["López","Escudero"],"rol":"Profesor","correo":"profe@correo","foto":"Screenshot%202023-05-08%20at%2022-19-19%20ThisPersonDoesNotExist%20-%20Random%20AI%20Generado%20Fotos%20de%20Personas%20Falsas.png","__v":1,"username":"profemusical","logros":["6452d2dbe0319ab98bd4993c","6452d2dbe0319ab98bd4993b","6452d2dbe0319ab98bd4993a","6452d3ace0319ab98bd4993f","6452d3ace0319ab98bd49940","6452d3ace0319ab98bd49943","6452d3ace0319ab98bd49941","6452d4d2e0319ab98bd49951"]},"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTNjNTZhYzI1ZDNhYTdhYzk4OGIiLCJpYXQiOjE2ODY3ODMwNjQsImV4cCI6MTY4Njc5NzQ2NH0.r5tzn1e4eBa5XJN7ji1cQkP_yvdZ1R-PriDwRytuwco","expiresIn":14400,"mensaje":"El usuario se ha encontrado"}');

        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introducción","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introducción","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introducción","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        await tester.pumpWidget(Container(
          child: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Auth(),
                ),
                ChangeNotifierProxyProvider<Auth, Lecciones>(
                    create: (_) => Lecciones(),
                    update: (ctx, auth, leccionesAnteriores) =>
                    leccionesAnteriores..update(auth.token)),
              ],
              child: Consumer<Auth>(
                builder: (ctx, auth, _) =>
                    MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: !auth.isAuth
                            ? PantallaLogin()
                            : PantallaLecciones(),
                      ),
                    ),
              )),
        ));
        await tester.pump();

        expect(find.text('INICIAR SESIÓN'), findsOneWidget);
        expect(find.text('MELOUDY'), findsWidgets);
        await tester.pump();

        await tester.enterText(find.byKey(Key('correo')), 'profe@correo');
        await tester.pump();

        await tester.enterText(find.byKey(Key('password')), 'profe');
        await tester.pump();

        await tester.tap(find.text('INICIAR SESIÓN'));

        await tester.pumpAndSettle();
        expect(find.text('Los instrumentos'), findsOneWidget);
      });

  testWidgets('El botón de Lecciones del dashboard funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introducción","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, Lecciones>(
                  create: (_) => Lecciones(),
                  update: (ctx, auth, leccionesAnteriores) =>
                  leccionesAnteriores..update(auth.token)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: PantallaDashboard(),
                      ),
                      routes: {
                        LeccionesPantallaProfesor.routeName: (ctx) =>
                            LeccionesPantallaProfesor(),
                      }),
            ),
          ),
        );
        await tester.pump();

        await tester.tap(find.text('Lecciones'));
        await tester.pumpAndSettle();

        expect(find.text('Crear Lección'), findsOneWidget);
        expect(find.text('Borrar'), findsWidgets);
      });

  testWidgets('La lección se carga correctamente', (WidgetTester tester) async {
    nock('http://${IP.ip}:5000')
        .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
        .reply(
        200,
        json.decode(
            '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introduccion","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Que es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

    nock('http://${IP.ip}:5000')
        .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
        .reply(
        200,
        json.decode(
            '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introduccion","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Que es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

    nock('http://${IP.ip}:5000')
        .get('/api/question/get-questions/63f94104d79a4308398b1f07')
        .reply(
        200,
        json.decode(
            '{"status":"success","preguntas":[{"_id":"6405144d20563dd96aaf6702","tipo":"unica","cuestion":"¿Qué es la música?","respuestascorrectas":["2"],"opciones":["Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro.","Es un hobbie que consiste en tocar un instrumento.","Es el arte de combinar el sonido con el tiempo.","Es el arte de estudiar el sonido y el tiempo."],"imagen":"queeslamusica.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405155820563dd96aaf6704","tipo":"unica","cuestion":"¿Qué es el sonido?","respuestascorrectas":["2"],"opciones":["Es lo contrario al ruido.","Es una onda que se propaga solo por el aire, producida por la vibración de un cuerpo sonoro.","Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro.","Es un rayo invisible que se propaga por el aire u otro medio."],"imagen":"queeselsonido.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405156b20563dd96aaf6705","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son cualidades de un sonido?","respuestascorrectas":["2","3","4"],"opciones":["melodia","decibelios","duracion","volumen","tono","agudo"],"imagen":"cualidadessonido.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"640515d420563dd96aaf6706","tipo":"unica","cuestion":"¿Qué es el ritmo?","respuestascorrectas":["0"],"opciones":["Es la distribución de sonidos en el tiempo.","Son los golpes de los tambores en una canción.","Es la distribución de sonidos en el espacio.","Es la duración de un sonido"],"imagen":"ritmo.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405160920563dd96aaf6707","tipo":"unica","cuestion":"¿La duración es una cualidad del sonido?","respuestascorrectas":["0"],"opciones":["Si","No"],"imagen":"duracion.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405166d20563dd96aaf6709","tipo":"unica","cuestion":"¿Qué es la melodía?","respuestascorrectas":["3"],"opciones":["Es la combinación de varias notas que suenan al mismo tiempo.","Es la parte musical de una canción.","Es una división del sonido de forma lineal.","Es una sucesión lineal de sonidos que es percibida como una sola unidad."],"imagen":"melodia.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405167720563dd96aaf670a","tipo":"unica","cuestion":"¿Qué es la armonía?","respuestascorrectas":["0"],"opciones":["Es la combinación de varias notas que suenan al mismo tiempo."," Es la combinación de varias notas que suenan consecutivamente.","Es una sucesión lineal de sonidos que es percibida como una sola unidad.","Es la música que suena bien."],"imagen":"armonia.jpg","leccion":"63f94104d79a4308398b1f07"},{"opciones":[],"_id":"64070c70f2b40de2eecc8d68","tipo":"texto","cuestion":"A la combinación de varias notas que suenan al mismo tiempo la llamamos...","imagen":"armonia2.png","respuestascorrectas":["armonía","armonia"],"leccion":"63f94104d79a4308398b1f07"},{"opciones":[],"_id":"640c6d743c121ec7c8211988","tipo":"texto","cuestion":"A la sucesión lineal de sonidos que es percibida como una sola unidad la llamamos...","imagen":"melodia2.png","respuestascorrectas":["melodia"],"leccion":"63f94104d79a4308398b1f07"},{"_id":"640c6de83c121ec7c8211989","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son elementos de la música?","respuestascorrectas":["0","2"],"opciones":["ritmo","tono","armonía","duración","grave"],"imagen":"elementosmusica.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"640c6e6e3c121ec7c821198a","tipo":"unica","cuestion":"¿Qué es la duración?","respuestascorrectas":["1"],"opciones":["Es lo mismo que el ritmo.","Es el tiempo que dura la vibración sonora.","Es una sucesión lineal de sonidos.","Es el tiempo que dura una canción."],"imagen":"duracion.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"640c70e43c121ec7c821198b","tipo":"unica","cuestion":"¿En qué unidad se mide el volumen?","respuestascorrectas":["0"],"opciones":["Decibelios (Db).","Frecuencia (Hz).","Puntos de volumen.","Vatios (W)."],"imagen":"volumen.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"646a4d56b6341df540d57eac","tipo":"unica","cuestion":"sdfsfd","respuestascorrectas":["0"],"opciones":["sdfsds","df"],"imagen":"musica.png","leccion":"63f94104d79a4308398b1f07","__v":0},{"_id":"648256c2cc09f8699098fda3","tipo":"multiple","cuestion":"prueba","respuestascorrectas":["a","c"],"opciones":["a","b","c","d"],"imagen":null,"leccion":"63f94104d79a4308398b1f07","__v":0}]}'));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Lecciones>(
              create: (_) => Lecciones(),
              update: (ctx, auth, leccionesAnteriores) =>
              leccionesAnteriores..update(auth.token)),
          ChangeNotifierProxyProvider<Auth, Preguntas>(
              create: (_) => Preguntas(),
              update: (ctx, auth, preguntasAnteriores) =>
              preguntasAnteriores..update(auth.token)),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) =>
              MaterialApp(
                  title: 'Meloudy',
                  theme: ThemeData(
                    scaffoldBackgroundColor: Paleta.blueBackground,
                    primarySwatch: Paleta.blueCustom,
                  ),
                  home: Scaffold(
                    body: PantallaLecciones(),
                  ),
                  routes: {
                    LeccionPantalla.routeName: (ctx) => LeccionPantalla(),
                  }),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Introduccion'), findsOneWidget);

    await tester.tap(find.text("Introduccion"));
    await tester.pumpAndSettle();

    expect(find.text('Historial'), findsOneWidget);
  });

  testWidgets('El botón de Logros del dashboard funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000')
            .get('/api/achievement/get-achievement/?auth=null')
            .reply(
            200,
            json.decode(
                '{"status":"success","logros":[{"_id":"64524acadf275dba34fa889b","nombre":"Amigable - Lvl 1","descripcion":"Hazte amigo de 3 usuarios","imagen":"9.png","tipo":"amigos","condicion":"3"},{"_id":"64524b6edf275dba34fa889c","nombre":"Amigable - Lvl 2","descripcion":"Hazte amigo de 10 usuarios","imagen":"10.png","tipo":"amigos","condicion":"10"},{"_id":"64524b74df275dba34fa889d","nombre":"Amigable - Lvl 3","descripcion":"Hazte amigo de 20 usuarios","imagen":"11.png","tipo":"amigos","condicion":"20"},{"_id":"64524b89df275dba34fa889e","nombre":"Amigable - Lvl 4","descripcion":"Hazte amigo de 50 usuarios","imagen":"12.png","tipo":"amigos","condicion":"50"},{"_id":"6452d1bfe0319ab98bd49930","nombre":"Sobresaliente - Lvl 1","descripcion":"Aprueba 5 tests","imagen":"1.png","tipo":"tests","condicion":"5"},{"_id":"6452d1bfe0319ab98bd49931","nombre":"Sobresaliente - Lvl 2","descripcion":"Aprueba 20 tests","imagen":"2.png","tipo":"tests","condicion":"20"},{"_id":"6452d1bfe0319ab98bd49933","nombre":"Sobresaliente - Lvl 4","descripcion":"Aprueba 100 tests","imagen":"4.png","tipo":"tests","condicion":"100"},{"_id":"6452d1bfe0319ab98bd49932","nombre":"Sobresaliente - Lvl 3","descripcion":"Aprueba 50 tests","imagen":"3.png","tipo":"tests","condicion":"50"},{"_id":"6452d24be0319ab98bd49938","nombre":"Estudiante - Lvl 4","descripcion":"Completa 40 lecciones","imagen":"8.png","tipo":"lecciones","condicion":"40"},{"_id":"6452d24be0319ab98bd49937","nombre":"Estudiante - Lvl 3","descripcion":"Completa 20 lecciones","imagen":"7.png","tipo":"lecciones","condicion":"20"},{"_id":"6452d24be0319ab98bd49935","nombre":"Estudiante - Lvl 1","descripcion":"Completa 3 lecciones","imagen":"5.png","tipo":"lecciones","condicion":"3"},{"_id":"6452d24be0319ab98bd49936","nombre":"Estudiante - Lvl 2","descripcion":"Completa 10 lecciones","imagen":"6.png","tipo":"lecciones","condicion":"10"},{"_id":"6452d2dbe0319ab98bd4993c","nombre":"Empollón - Lvl 3","descripcion":"Contesta 100 pregutas correctamente","imagen":"14.png","tipo":"preguntas","condicion":"100"},{"_id":"6452d2dbe0319ab98bd4993d","nombre":"Empollón - Lvl 4","descripcion":"Contesta 200 pregutas correctamente","imagen":"16.png","tipo":"preguntas","condicion":"200"},{"_id":"6452d2dbe0319ab98bd4993a","nombre":"Empollón - Lvl 1","descripcion":"Contesta 20 pregutas correctamente","imagen":"13.png","tipo":"preguntas","condicion":"20"},{"_id":"6452d2dbe0319ab98bd4993b","nombre":"Empollón - Lvl 2","descripcion":"Contesta 50 pregutas correctamente","imagen":"15.png","tipo":"preguntas","condicion":"50"},{"_id":"6452d3ace0319ab98bd4993f","nombre":"Preciso - Lvl 1","descripcion":"Contesta 20 pregutas de tipo unica correctamente","imagen":"17.png","tipo":"preguntasunica","condicion":"20"},{"_id":"6452d3ace0319ab98bd49942","nombre":"Preciso - Lvl 4","descripcion":"Contesta 200 pregutas de tipo única correctamente","imagen":"20.png","tipo":"preguntasunica","condicion":"200"},{"_id":"6452d3ace0319ab98bd49941","nombre":"Preciso - Lvl 3","descripcion":"Contesta 100 pregutas de tipo única correctamente","imagen":"18.png","tipo":"preguntasunica","condicion":"100"},{"_id":"6452d3ace0319ab98bd49945","nombre":"Seleccionador - Lvl 3","descripcion":"Contesta 100 pregutas de tipo múltiple correctamente","imagen":"22.png","tipo":"preguntasmultiple","condicion":"100"},{"2":"Contesta 50 pregutas de tipo múltiple correctamente","_id":"6452d3ace0319ab98bd49944","nombre":"Seleccionador - Lvl 2","imagen":"23.png","descripcion":"Contesta 50 pregutas de tipo múltiple correctamente","tipo":"preguntasmultiple","condicion":"50"},{"_id":"6452d3ace0319ab98bd49946","nombre":"Seleccionador - Lvl 4","descripcion":"Contesta 200 pregutas de tipo múltiple correctamente","imagen":"24.png","tipo":"preguntasmultiple","condicion":"200"},{"_id":"6452d3ace0319ab98bd49940","nombre":"Preciso - Lvl 2","descripcion":"Contesta 50 pregutas de tipo única correctamente","imagen":"19.png","tipo":"preguntasunica","condicion":"50"},{"_id":"6452d3ace0319ab98bd49943","nombre":"Seleccionador - Lvl 1","descripcion":"Contesta 20 pregutas de tipo múltiple correctamente","imagen":"21.png","tipo":"preguntasmultiple","condicion":"20"},{"_id":"6452d48ae0319ab98bd4994a","nombre":"Intérprete - Lvl 2","descripcion":"Contesta 50 pregutas de tipo micrófono correctamente","imagen":"27.png","tipo":"preguntasmicro","condicion":"50"},{"_id":"6452d48ae0319ab98bd4994b","nombre":"Intérprete - Lvl 3","descripcion":"Contesta 100 pregutas de tipo micrófono correctamente","imagen":"26.png","tipo":"preguntasmicro","condicion":"100"},{"_id":"6452d48ae0319ab98bd4994c","nombre":"Intérprete - Lvl 4","descripcion":"Contesta 200 pregutas de tipo micrófono correctamente","imagen":"28.png","tipo":"preguntasmicro","condicion":"200"},{"_id":"6452d48ae0319ab98bd4994d","nombre":"Escritor - Lvl 1","descripcion":"Contesta 20 pregutas de tipo texto correctamente","imagen":"29.png","tipo":"preguntastexto","condicion":"20"},{"_id":"6452d48ae0319ab98bd4994e","nombre":"Escritor - Lvl 2","descripcion":"Contesta 50 pregutas de tipo texto correctamente","imagen":"31.png","tipo":"preguntastexto","condicion":"50"},{"_id":"6452d48ae0319ab98bd49950","nombre":"Escritor - Lvl 4","descripcion":"Contesta 200 pregutas de tipo texto correctamente","imagen":"32.png","tipo":"preguntastexto","condicion":"200"},{"_id":"6452d48ae0319ab98bd49949","nombre":"Intérprete - Lvl 1","descripcion":"Contesta 20 pregutas de tipo micrófono correctamente","imagen":"25.png","tipo":"preguntasmicro","condicion":"20"},{"_id":"6452d48ae0319ab98bd4994f","nombre":"Escritor - Lvl 3","descripcion":"Contesta 100 pregutas de tipo texto correctamente","imagen":"30.png","tipo":"preguntastexto","condicion":"100"},{"_id":"6452d4d2e0319ab98bd49951","nombre":"Novato","descripcion":"Completa la lección Introducción","imagen":"33.png","tipo":"leccion","condicion":"63f94104d79a4308398b1f07"},{"_id":"6452d4ebe0319ab98bd49952","nombre":"Principiante","descripcion":"Completa la lección Notas musicales","imagen":"34.png","tipo":"leccion","condicion":"63f941efd79a4308398b1f09"},{"_id":"6452d514e0319ab98bd49954","nombre":"Aprendiz","descripcion":"Completa la lección Figuras musicales","imagen":"35.png","tipo":"amigos","condicion":"3"},{"_id":"6452d535e0319ab98bd49955","nombre":"Alumno","descripcion":"Completa la lección Instrumentos musicales","imagen":"36.png","tipo":"leccion","condicion":"64387a88b5af7c8a197a70cf"},{"_id":"6477a82ba4f8695053c2ca8d","nombre":"Músico","descripcion":"Completar la lección Los Instrumentos","imagen":"36.png","tipo":"leccion","condicion":"64387a88b5af7c8a197a70cf","__v":0},{"_id":"6477a9c7a4f8695053c2d57c","nombre":"zssd","descripcion":"sdsdsd","imagen":"36.png","tipo":"leccion","condicion":"63f941efd79a4308398b1f09","__v":0},{"_id":"64838190a3d806176d02cb70","nombre":"prueba","descripcion":"prueba","imagen":"prueba.png","tipo":"lecciones","condicion":"3","__v":0}],"mensaje":"Los logros se han encontrado"}'));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, Logros>(
                  create: (_) => Logros(),
                  update: (ctx, auth, logrosAnteriores) =>
                  logrosAnteriores..update(auth.token)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: PantallaDashboard(),
                      ),
                      routes: {
                        PantallaLogrosProfesor.routeName: (ctx) =>
                            PantallaLogrosProfesor(),
                      }),
            ),
          ),
        );
        await tester.pump();

        await tester.tap(find.text('Logros'));
        await tester.pumpAndSettle();

        expect(find.text('Crear Logro'), findsOneWidget);
        expect(find.text('Borrar'), findsWidgets);
      });


  testWidgets('El botón de Preguntas del dashboard funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000').get(
            '/api/question/get-questions?auth=null').reply(
            200,
            json.decode(
                '{"status":"success","preguntas":[{"_id":"6405144d20563dd96aaf6702","tipo":"unica","cuestion":"¿Qué es la música?","respuestascorrectas":["2"],"opciones":["Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro.","Es un hobbie que consiste en tocar un instrumento.","Es el arte de combinar el sonido con el tiempo.","Es el arte de estudiar el sonido y el tiempo."],"imagen":"queeslamusica.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405155820563dd96aaf6704","tipo":"unica","cuestion":"¿Qué es el sonido?","respuestascorrectas":["2"],"opciones":["Es lo contrario al ruido.","Es una onda que se propaga solo por el aire, producida por la vibración de un cuerpo sonoro.","Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro.","Es un rayo invisible que se propaga por el aire u otro medio."],"imagen":"queeselsonido.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405156b20563dd96aaf6705","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son cualidades de un sonido?","respuestascorrectas":["2","3","4"],"opciones":["melodia","decibelios","duracion","volumen","tono","agudo"],"imagen":"cualidadessonido.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"640515d420563dd96aaf6706","tipo":"unica","cuestion":"¿Qué es el ritmo?","respuestascorrectas":["0"],"opciones":["Es la distribución de sonidos en el tiempo.","Son los golpes de los tambores en una canción.","Es la distribución de sonidos en el espacio.","Es la duración de un sonido"],"imagen":"ritmo.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405160920563dd96aaf6707","tipo":"unica","cuestion":"¿La duración es una cualidad del sonido?","respuestascorrectas":["0"],"opciones":["Si","No"],"imagen":"duracion.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405166d20563dd96aaf6709","tipo":"unica","cuestion":"¿Qué es la melodía?","respuestascorrectas":["3"],"opciones":["Es la combinación de varias notas que suenan al mismo tiempo.","Es la parte musical de una canción.","Es una división del sonido de forma lineal.","Es una sucesión lineal de sonidos que es percibida como una sola unidad."],"imagen":"melodia.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"6405167720563dd96aaf670a","tipo":"unica","cuestion":"¿Qué es la armonía?","respuestascorrectas":["0"],"opciones":["Es la combinación de varias notas que suenan al mismo tiempo."," Es la combinación de varias notas que suenan consecutivamente.","Es una sucesión lineal de sonidos que es percibida como una sola unidad.","Es la música que suena bien."],"imagen":"armonia.jpg","leccion":"63f94104d79a4308398b1f07"},{"opciones":[],"_id":"64070c70f2b40de2eecc8d68","tipo":"texto","cuestion":"A la combinación de varias notas que suenan al mismo tiempo la llamamos...","imagen":"armonia2.png","respuestascorrectas":["armonía","armonia"],"leccion":"63f94104d79a4308398b1f07"},{"opciones":[],"_id":"640c6d743c121ec7c8211988","tipo":"texto","cuestion":"A la sucesión lineal de sonidos que es percibida como una sola unidad la llamamos...","imagen":"melodia2.png","respuestascorrectas":["melodia"],"leccion":"63f94104d79a4308398b1f07"},{"_id":"640c6de83c121ec7c8211989","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son elementos de la música?","respuestascorrectas":["0","2"],"opciones":["ritmo","tono","armonía","duración","grave"],"imagen":"elementosmusica.png","leccion":"63f94104d79a4308398b1f07"},{"_id":"640c6e6e3c121ec7c821198a","tipo":"unica","cuestion":"¿Qué es la duración?","respuestascorrectas":["1"],"opciones":["Es lo mismo que el ritmo.","Es el tiempo que dura la vibración sonora.","Es una sucesión lineal de sonidos.","Es el tiempo que dura una canción."],"imagen":"duracion.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"640c70e43c121ec7c821198b","tipo":"unica","cuestion":"¿En qué unidad se mide el volumen?","respuestascorrectas":["0"],"opciones":["Decibelios (Db).","Frecuencia (Hz).","Puntos de volumen.","Vatios (W)."],"imagen":"volumen.jpg","leccion":"63f94104d79a4308398b1f07"},{"_id":"641763cb61811e56c3af6d38","tipo":"unica","cuestion":"¿Qué es el pentagrama?","respuestascorrectas":["0"],"opciones":["Es una pauta formada por 5 lineas horizontales y paralelas que se utiliza para escribir música","Es una pauta formada por 4 líneas horizontales y paralelas que se utiliza para escribir música","Es una pauta formada por 5 lineas verticales y paralelas que se utiliza para escribir música","Son líneas y espacios puestos de forma aleatoria"],"imagen":"pentagrama.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641783fb47a086cf61a26b82","tipo":"unica","cuestion":"¿Qué es una clave?","respuestascorrectas":["2"],"opciones":["Es un símbolo que se escribe al final del pentagrama para indicar dónde están las notas","Es un símbolo que sirve para indicar dónde empieza el pentagrama","Es un símbolo que se escribe al principio del pentagrama para indicar dónde están las notas","Es una contraseña musical"],"imagen":"claves.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641786a347a086cf61a26b83","tipo":"unica","cuestion":"¿Qué nombre tiene la siguiente figura?","respuestascorrectas":["3"],"opciones":["Do","Clave de Do","Clave de Fa","Clave de Sol"],"imagen":"clavedesol.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"6417876a47a086cf61a26b84","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son notas musicales?","respuestascorrectas":["0","2","3","6"],"opciones":["Do","Se","Re","Sol","Fi","Ma","Si"],"imagen":"notas.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641787a547a086cf61a26b85","tipo":"multiple","cuestion":"¿Cuáles de las siguientes opciones son notas musicales?","respuestascorrectas":["0","1","3","4"],"opciones":["B","D","H","A","F","Z"],"imagen":"notas.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"6417880f47a086cf61a26b86","tipo":"texto","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["Re"],"imagen":"notare.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"6417882547a086cf61a26b87","tipo":"texto","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["Sol"],"imagen":"notasol.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"6417883d47a086cf61a26b88","tipo":"texto","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["Si"],"imagen":"notasi.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"6417887047a086cf61a26b89","tipo":"unica","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["0"],"opciones":["Re","Mi","Sol","Sa"],"imagen":"notare.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641788da47a086cf61a26b8a","tipo":"unica","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["2"],"opciones":["Li","Sol","Fa","La"],"imagen":"notafa.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641788f147a086cf61a26b8b","tipo":"unica","cuestion":"¿Cuál es la nota musical de la imagen?","respuestascorrectas":["0"],"opciones":["La","Si","Sol","Mi"],"imagen":"notala.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"6417899847a086cf61a26b8c","tipo":"unica","cuestion":"¿Cómo se escribe la nota La en el sistema anglosajón?","respuestascorrectas":["2"],"opciones":["B","F","A","H"],"imagen":"notala.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"641789ca47a086cf61a26b8d","tipo":"unica","cuestion":"¿Cómo se escribe la nota Si en el sistema anglosajón?","respuestascorrectas":["1"],"opciones":["D","B","E","G"],"imagen":"notasi.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"64178a2647a086cf61a26b8e","tipo":"texto","cuestion":"¿Cómo se escribe la nota Do en el sistema anglosajón?","respuestascorrectas":["C"],"imagen":"notado.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"64178afd47a086cf61a26b8f","tipo":"unica","cuestion":"¿Cómo se llaman las líneas que se usan cuando el pentagrama se expande?","respuestascorrectas":["0"],"opciones":["adicionales","extra","de expansión","horizontales"],"imagen":"notasi.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"6418ac0d40cb5401bd42ea38","tipo":"microfono","cuestion":"Toca la siguiente nota","respuestascorrectas":["E"],"imagen":"notami.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"6419f84ed2a3bcb8b2fb9987","tipo":"microfono","cuestion":"Toca la siguiente nota","respuestascorrectas":["G"],"imagen":"notasol.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"641e242f56008c2b3bb76f29","tipo":"microfono","cuestion":"Toca las siguientes notas","respuestascorrectas":["E","F","G","C"],"imagen":"partitura1.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"641e244456008c2b3bb76f2a","tipo":"microfono","cuestion":"Toca las siguientes notas","respuestascorrectas":["G","E","F","B"],"imagen":"partitura2.png","leccion":"63f941efd79a4308398b1f09"},{"opciones":[],"_id":"641e24d256008c2b3bb76f2b","tipo":"microfono","cuestion":"Toca las siguientes notas","respuestascorrectas":["C","C","D","C","F","E"],"imagen":"partitura3.png","leccion":"63f941efd79a4308398b1f09"},{"_id":"646a4d56b6341df540d57eac","tipo":"unica","cuestion":"sdfsfd","respuestascorrectas":["0"],"opciones":["sdfsds","df"],"imagen":"musica.png","leccion":"63f94104d79a4308398b1f07","__v":0},{"_id":"648256c2cc09f8699098fda3","tipo":"multiple","cuestion":"prueba","respuestascorrectas":["a","c"],"opciones":["a","b","c","d"],"imagen":null,"leccion":"63f94104d79a4308398b1f07","__v":0}]}'));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, PreguntasProfesor>(
                  create: (_) => PreguntasProfesor(),
                  update: (ctx, auth, preguntasAnteriores) =>
                  preguntasAnteriores..update(auth.token)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: PantallaDashboard(),
                      ),
                      routes: {
                        PantallaPreguntasProfesor.routeName: (ctx) =>
                            PantallaPreguntasProfesor(),
                      }),
            ),
          ),
        );
        await tester.pump();

        await tester.tap(find.text('Preguntas'));
        await tester.pumpAndSettle();

        expect(find.text('Crear Pregunta'), findsOneWidget);
        expect(find.text('Borrar'), findsWidgets);
      });

  testWidgets('El botón de Usuarios del dashboard funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000')
            .get('/api/user/get-users/?auth=null')
            .reply(
            200,
            json.decode(
                '{"status":"success","usuario":[{"logros":[],"_id":"63f7e9af9d75e6e6c062c582","nombre":"Sergio","password":"2b10xwdH9OCEwXaUgfSfLrQbOOX8.OmxouneP9HWIKharg9M8E4sSA4l2","apellidos":["Hervás","Cobo"],"rol":"Usuario","correo":"sergio@correo","foto":"persona1.png","__v":0,"username":"sergio17"},{"_id":"63fe53c56ac25d3aa7ac988b","nombre":"Luis","password":"BZE7YIw2Ia41jB3sP7xcCeII6K27zWOo6tP5LT9V6Gfix8jGqU6KW","apellidos":["López","Escudero"],"rol":"Profesor","correo":"profe@correo","foto":"Screenshot%202023-05-08%20at%2022-19-19%20ThisPersonDoesNotExist%20-%20Random%20AI%20Generado%20Fotos%20de%20Personas%20Falsas.png","__v":1,"username":"profemusical","logros":["6452d2dbe0319ab98bd4993c","6452d2dbe0319ab98bd4993b","6452d2dbe0319ab98bd4993a","6452d3ace0319ab98bd4993f","6452d3ace0319ab98bd49940","6452d3ace0319ab98bd49943","6452d3ace0319ab98bd49941","6452d4d2e0319ab98bd49951"]}],"mensaje":"Los usuarios se han encontrado"}'));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, Usuarios>(
                  create: (_) => Usuarios(),
                  update: (ctx, auth, usuariosAnteriores) =>
                  usuariosAnteriores..update(auth.token)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: PantallaDashboard(),
                      ),
                      routes: {
                        PantallaUsuariosProfesor.routeName: (ctx) =>
                            PantallaUsuariosProfesor(),
                      }),
            ),
          ),
        );
        await tester.pump();

        await tester.tap(find.text('Usuarios'));
        await tester.pumpAndSettle();

        expect(find.text('Crear Usuario'), findsOneWidget);
        expect(find.text('Borrar'), findsWidgets);
      });

  testWidgets('El botón de Inicio del Drawer funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introduccion","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Que es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introduccion","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Que es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"Que es el sonido"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        nock('http://${IP.ip}:5000')
            .get('/api/lesson/get-lessons/63fe53c56ac25d3aa7ac988b')
            .reply(
            200,
            json.decode(
                '{"status":"success","tests":[{"idLeccion":"63f94104d79a4308398b1f07","testsAprobados":21},{"idLeccion":"63f941efd79a4308398b1f09","testsAprobados":0}],"progreso":[{"_id":"640b00953b591db90fceb7b1","tests":["6462a2a0225c93f0488842c4","6462a323225c93f048884330","6462a942cfa832e841abe4bc","6462b0f464bd0eebefbb223d","6463f3688c2b6286f7e6f142","6463f6a32606c48c3af9a013","6463f89c01379949cfc3e74f","6463f9752afc6dcccec57a12","6463f9f0dbc909175a27b4bb","6463fa69b79137a9948ab38c","6463fb0fc619a45251a81cfb","6463fcb7cfa8f090e22704a9","6463fe830f2be99c40795f40","6463ff7ffff8e6de45c739df","646400379180fbf28af24b98","646400b45ca211fe0422a78c","64640152a17e89692d9b63c6","646402bfd8e5522c39fedec5","64640396525b19529562d016","64640661b66062ee2443445f","646406a2d256fbc576181989"],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f94104d79a4308398b1f07","__v":74,"completado":true},{"_id":"645c1708eb76fda410d2fbe0","tests":[],"idUsuario":"63fe53c56ac25d3aa7ac988b","idLeccion":"63f941efd79a4308398b1f09","completado":false,"__v":7}],"leccion":[{"_id":"63f94104d79a4308398b1f07","nombre":"Introducción","texto":"adasdasdasdasd","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"musica.png"},{"_id":"64387a88b5af7c8a197a70cf","nombre":"Los instrumentos","imagenprincipal":"musica.jpg","contenido":[{"tipo":"img","texto":"orquesta.jpg"},{"tipo":"img","texto":""}],"__v":0},{"_id":"63f941fed79a4308398b1f0a","nombre":"Figuras musicales","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"¿Qué es el sonido?"},{"tipo":"texto","texto":"Es una onda que se propaga por el aire u otro medio, producida por la vibración de un cuerpo sonoro. El sonido posee las siguientes cualidades físicas: • Tono:  Viene determinada por la frecuencia de la vibración sonora y se mide en Hercios (Hz). Nos permite reconocer si un sonido es agudo (alta frecuencia) o grave (baja frecuencia). • Volumen: Intensidad o amplitud de la vibración sonora. Se mide en Decibelios (dB) y clasifica los sonidos en fuertes o suaves. • Duración: Tiempo que dura la vibración sonora. Está asociada al ritmo musical. • Timbre: Aquel que nos permite distinguir dos sonidos de igual tono(frecuencia) e intensidad. "},{"tipo":"img","texto":"musica1.png"},{"tipo":"titulo","texto":"¿Qué es la música?"},{"tipo":"texto","texto":"Es el arte de combinar el sonido con el tiempo. Tiene tres elementos fundamentales:"},{"tipo":"titulo","texto":"Melodía"},{"tipo":"texto","texto":"Es una sucesión lineal de sonidos que es percibida como una sola unidad."},{"tipo":"titulo","texto":"Armonía"},{"tipo":"texto","texto":"Es la combinación de varias notas que suenan al mismo tiempo."},{"tipo":"titulo","texto":"Ritmo"},{"tipo":"texto","texto":"Es la distribución de sonidos en el tiempo."},{"tipo":"img","texto":"metronomo.png"},{"tipo":"titulo","texto":"¿Qué es el lenguaje musical?"},{"tipo":"texto","texto":"Estudio de las cualidades o elementos de la música."}],"imagenprincipal":"leccion3.png"},{"_id":"63f941efd79a4308398b1f09","nombre":"pruebamodificada","texto":"dasdsdasdasdasdasdasda","contenido":[{"tipo":"titulo","texto":"ad"},{"tipo":"imagen","texto":"bd"},{"tipo":"texto","texto":"cd"},{"tipo":"titulo","texto":"dd"},{"tipo":"texto","texto":"ed"}],"imagenprincipal":"pruebamod.png"}],"mensaje":"Las lecciones se ha encontrado"}'));

        final scaffoldKey = GlobalKey<ScaffoldState>();
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, Lecciones>(
                  create: (_) => Lecciones(),
                  update: (ctx, auth, leccionesAnteriores) =>
                  leccionesAnteriores..update(auth.token)),
              ChangeNotifierProxyProvider<Auth, Usuarios>(
                  create: (_) => Usuarios(),
                  update: (ctx, auth, usuariosAnteriores) =>
                  usuariosAnteriores..update(auth.token)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: Container(),
                        drawer: DrawerApp(),
                      ),
                      routes: {
                        PantallaUsuariosProfesor.routeName: (ctx) =>
                            PantallaUsuariosProfesor(),
                        PantallaLecciones.routeName: (ctx) =>
                            PantallaLecciones(),
                      }),
            ),
          ),
        );
        await tester.pump();

        final ScaffoldState scafState = tester.firstState(
            find.byType(Scaffold));
        scafState.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Inicio'));
        await tester.pumpAndSettle();

        expect(find.text('Los instrumentos'), findsOneWidget);
      });

  testWidgets('El botón de Perfil del Drawer funciona correctamente',
          (WidgetTester tester) async {
        nock('http://${IP.ip}:5000')
            .get('/api/user/get-user/63fe53c56ac25d3aa7ac988b?auth=null')
            .reply(
            200,
            json.decode(
                '{"status":"success","usuario":{"_id":"63fe53c56ac25d3aa7ac988b","nombre":"Luis","password":"BZE7YIw2Ia41jB3sP7xcCeII6K27zWOo6tP5LT9V6Gfix8jGqU6KW","apellidos":["López","Escudero"],"rol":"Profesor","correo":"profe@correo","foto":"Screenshot%202023-05-08%20at%2022-19-19%20ThisPersonDoesNotExist%20-%20Random%20AI%20Generado%20Fotos%20de%20Personas%20Falsas.png","__v":1,"username":"profemusical","logros":["6452d2dbe0319ab98bd4993c","6452d2dbe0319ab98bd4993b","6452d2dbe0319ab98bd4993a","6452d3ace0319ab98bd4993f","6452d3ace0319ab98bd49940","6452d3ace0319ab98bd49943","6452d3ace0319ab98bd49941","6452d4d2e0319ab98bd49951"]},"logros":[{"_id":"6452d2dbe0319ab98bd4993c","nombre":"Empollón - Lvl 3","descripcion":"Contesta 100 pregutas correctamente","imagen":"14.png","tipo":"preguntas","condicion":"100"},{"_id":"6452d2dbe0319ab98bd4993b","nombre":"Empollón - Lvl 2","descripcion":"Contesta 50 pregutas correctamente","imagen":"15.png","tipo":"preguntas","condicion":"50"},{"_id":"6452d2dbe0319ab98bd4993a","nombre":"Empollón - Lvl 1","descripcion":"Contesta 20 pregutas correctamente","imagen":"13.png","tipo":"preguntas","condicion":"20"},{"_id":"6452d3ace0319ab98bd4993f","nombre":"Preciso - Lvl 1","descripcion":"Contesta 20 pregutas de tipo única correctamente","imagen":"17.png","tipo":"preguntasunica","condicion":"20"},{"_id":"6452d3ace0319ab98bd49940","nombre":"Preciso - Lvl 2","descripcion":"Contesta 50 pregutas de tipo única correctamente","imagen":"19.png","tipo":"preguntasunica","condicion":"50"},{"_id":"6452d3ace0319ab98bd49943","nombre":"Seleccionador - Lvl 1","descripcion":"Contesta 20 pregutas de tipo múltiple correctamente","imagen":"21.png","tipo":"preguntasmultiple","condicion":"20"},{"_id":"6452d3ace0319ab98bd49941","nombre":"Preciso - Lvl 3","descripcion":"Contesta 100 pregutas de tipo única correctamente","imagen":"18.png","tipo":"preguntasunica","condicion":"100"},{"_id":"6452d4d2e0319ab98bd49951","nombre":"Novato","descripcion":"Completa la lección Introducción","imagen":"33.png","tipo":"leccion","condicion":"63f94104d79a4308398b1f07"}],"mensaje":"El usuario se ha encontrado"}'));

        final scaffoldKey = GlobalKey<ScaffoldState>();
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProxyProvider<Auth, Lecciones>(
                  create: (_) => Lecciones(),
                  update: (ctx, auth, leccionesAnteriores) =>
                  leccionesAnteriores..update(auth.token)),
              ChangeNotifierProxyProvider<Auth, UsuarioPerfil>(
                  update: (ctx,
                      auth,
                      userant,) =>
                      UsuarioPerfil(
                          auth.token,
                          userant == null ? Usuario() : userant.item)),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  MaterialApp(
                      title: 'Meloudy',
                      theme: ThemeData(
                        scaffoldBackgroundColor: Paleta.blueBackground,
                        primarySwatch: Paleta.blueCustom,
                      ),
                      home: Scaffold(
                        body: Container(),
                        drawer: DrawerApp(),
                      ),
                      routes: {
                        PantallaUsuariosProfesor.routeName: (ctx) =>
                            PantallaUsuariosProfesor(),
                        PantallaLecciones.routeName: (ctx) =>
                            PantallaLecciones(),
                        PantallaUsuario.routeName: (ctx) => PantallaUsuario(),
                      }),
            ),
          ),
        );
        await tester.pump();

        final ScaffoldState scafState = tester.firstState(
            find.byType(Scaffold));
        scafState.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Perfil'));
        await tester.pumpAndSettle();

        expect(find.text('Mi perfil'), findsOneWidget);
      });
}