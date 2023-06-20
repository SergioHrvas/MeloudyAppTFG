import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/lecciones_pantalla_profesor.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../providers/logros.dart';
import '../providers/preguntas_profesor.dart';
import '../providers/usuarios.dart';
import '../widget/dashboard.dart';

class PantallaDashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DASHBOARD"),
        ),
        drawer: DrawerApp(),
        body: Dashboard());
  }
}

