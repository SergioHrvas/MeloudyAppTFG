import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/drawer_app.dart';

import '../widget/pregunta_widget.dart';

class PreguntaPantalla extends StatelessWidget {
  static const routeName = '/pregunta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TEST"),
        ),
        drawer: DrawerApp(),
        body: SingleChildScrollView(child: PreguntaWidget()));
  }
}
