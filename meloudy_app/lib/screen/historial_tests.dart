

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pregunta_pantalla.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/lecciones.dart';
import '../providers/preguntas.dart';
import '../widget/drawer_app.dart';

class HistorialTests extends StatelessWidget{
  static const routeName = '/historial-tests';

  Widget build(BuildContext context){

    var leccionid = ModalRoute.of(context).settings.arguments as String; // is the id!

    var tests = Provider.of<Lecciones>(context, listen: false).findById(leccionid).tests;

    List<Widget> lista = [];

    for(var i = 0; i < tests.length; i++){
      lista.add(        Container(
        alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("ACIERTOS: ${tests[i].aciertos}/10"),
                    Text("${tests[i].fecha_creacion}"),
                  ],
                ),Text("${tests[i].id}"),
                ElevatedButton(onPressed: (){
                  Provider.of<Preguntas>(context, listen:false).vaciarPreguntas();

                  Provider.of<Preguntas>(context, listen:false).setPreguntas(tests[i].id).then((resultado){
                    Provider.of<Preguntas>(context, listen: false).setModo('revisando');
                    Navigator.pushNamed(context, PreguntaPantalla.routeName);

                  });

                }, child: Text("Revisar Test"))
              ]
          )
      ));
    }

    return Scaffold(
        appBar: AppBar(title: Text("MELOUDY")),
    drawer: DrawerApp(),
    body: SingleChildScrollView(
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: lista,
      ),
    )
    )
    );
  }


}