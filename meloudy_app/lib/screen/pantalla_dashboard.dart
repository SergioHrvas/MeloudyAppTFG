

import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/lecciones_pantalla_profesor.dart';
import 'package:meloudy_app/widget/drawer_app.dart';

class PantallaDashboard extends StatelessWidget{
  static const routeName = '/dashboard';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("DASHBOARD"),),
      drawer: DrawerApp(),
      body: Container(child: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed(
              LeccionesPantallaProfesor.routeName,
            );
          }, child: Text("Lecciones")),
          ElevatedButton(onPressed: (){}, child: Text("Preguntas")),
          ElevatedButton(onPressed: (){}, child: Text("Usuarios")),

        ],
      ))

    );
  }
}