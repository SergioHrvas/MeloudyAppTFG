import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/auth.dart';
import '../providers/lecciones.dart';
import '../providers/opciones.dart';
import '../providers/preguntas_profesor.dart';
import '../widget/drawer_app.dart';

class PantallaPreguntasProfesor extends StatefulWidget {
  static const routeName = '/listapreguntas';

  @override
  _PantallaPreguntasProfesorState createState() =>
      _PantallaPreguntasProfesorState();
}

class _PantallaPreguntasProfesorState extends State<PantallaPreguntasProfesor> {
  _PantallaPreguntasProfesorState();

  @override
  Widget build(BuildContext context) {
    var preguntas =
        Provider.of<PreguntasProfesor>(context, listen: false).items;

    var preguntasWidget = [];
    for (var i = 0; i < preguntas.length; i++) {
      preguntasWidget.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('http://${IP.ip}:5000/img/${preguntas[i].imagen}'),
                  ),
                ),
              ),
              Container(
                child: Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),

                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 15,bottom: 10),
                            child: Row(
                              children: [
                                Expanded(child: Text(preguntas[i].cuestion, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                                GestureDetector(
                                  onTap: (){
                                    var opciones = Provider.of<PreguntasProfesor>(context, listen: false).getOpciones(preguntas[i].id);
                                    print("OPCIONES" + opciones.toString());
                                    Provider.of<Opciones>(context, listen:false).setOpciones(opciones['respuestascorrectas'], opciones['opciones']).then((Null){
                                      Navigator.pushNamed(context, '/editarpregunta',arguments: {
                                        "id": preguntas[i].id
                                      });
                                    });

                                  },
                                  child: Container(margin: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.edit_document, color: Colors.blue)),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Tipo: " + preguntas[i].tipo)),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Id: " + preguntas[i].id)),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(onPressed:(){
                    var id = Provider.of<Auth>(context, listen:false).userId;
                    Provider.of<Lecciones>(context, listen: false).fetchAndSetLecciones(id).then((_){
                      Navigator.pushNamed(context, '/crearpregunta');
                    }
                    );
                  },
                    child: Container(
                      width: 175,
                      child: Row(
                        children: [
                          Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.add_comment)),
                          Text("Crear pregunta",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),)),
              ...preguntasWidget],
          ),
        ),
      ),
    );
  }
}
