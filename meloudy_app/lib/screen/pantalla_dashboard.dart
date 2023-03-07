

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
      body: Container(
        padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center, child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(180, 50), primary: Colors.purple),onPressed: (){
              Navigator.of(context).pushNamed(
                LeccionesPantallaProfesor.routeName,
              );

            }, child: Text("Lecciones")),
          ),
          Container(            margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(180, 50), primary: Colors.purple), onPressed: (){}, child: Text("Preguntas"))),
          Container(            margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(180, 50), primary: Colors.purple), onPressed: (){}, child: Text("Usuarios"))),

        ],
      ))

    );
  }
}