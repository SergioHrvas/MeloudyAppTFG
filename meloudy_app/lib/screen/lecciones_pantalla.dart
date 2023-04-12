import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/lecciones_lista.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/lecciones.dart';

class LeccionesPantalla extends StatefulWidget{
  @override _LeccionesPantallaState createState() => _LeccionesPantallaState();

}
class _LeccionesPantallaState extends State<LeccionesPantalla> {
  final lecciones = [];

  _LeccionesPantallaState();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: RefreshIndicator(
        onRefresh: () async
    {
      var id = Provider.of<Auth>(context, listen:false).userId;
      await Provider.of<Lecciones>(context, listen: false).fetchAndSetLecciones(id);
    },
          child: Stack(children:[
            ListView(),
           SingleChildScrollView(child: LeccionesLista()),
          ])),
    );
  }
}
