import 'package:flutter/material.dart';
import '../extensiones.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../modo.dart';
import '../providers/auth.dart';
import '../providers/lecciones.dart';
import '../providers/notas.dart';
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

  var preguntas = [];

  showAlertDialog(BuildContext context, id, i) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("Borrar"),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        setState(() {
          preguntas.removeAt(i);
        });

        Provider.of<PreguntasProfesor>(context, listen: false).borrarPregunta(id)
            .then((_) {
          Navigator.of(context).pop();
        });
      },
    );

    Widget noButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("¿Desea eliminar la lección?"),
      content: Text(
          "Pulse \"Confirmar\" si desea eliminarla. En caso contrario pulse \"Cancelar\"."),
      actions: [
        noButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    preguntas =
        Provider.of<PreguntasProfesor>(context, listen: false).items;

    var preguntasWidget = [];
    for (var i = 0; i < preguntas.length; i++) {
      preguntasWidget.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        decoration: BoxDecoration(        borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(124, 135, 255, 0.615686274509804),),
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
                    image: MODO.modo != 1 ? NetworkImage(
                        'http://${IP.ip}:5000/img/${preguntas[i].imagen}') : AssetImage('assets/musica.png'),
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
                            margin: EdgeInsets.only(left: 15, bottom: 10),
                            child:
                                Container(
                                    child: Text(
                                  preguntas[i].cuestion.toString().useCorrectEllipsis(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                  overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                      softWrap: false,
                                )),
),
                        Container(
                            margin: EdgeInsets.only(left: 10, bottom: 5),
                            alignment: Alignment.center,
                            child: Text("Tipo: " + preguntas[i].tipo, style: TextStyle(fontSize: 20),)),

                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showAlertDialog(context, preguntas[i].id, i);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        Text("Borrar", style: TextStyle(fontSize: 20),),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    onPressed: () {

                                      var opciones =
                                      Provider.of<PreguntasProfesor>(context,
                                          listen: false)
                                          .getOpciones(preguntas[i].id);

                                      if (preguntas[i].tipo == "microfono") {
                                        Provider.of<Notas>(context, listen: false)
                                            .setNotas(
                                            opciones['respuestascorrectas'])
                                            .then((Null) {
                                          Navigator.pushNamed(
                                              context, '/editarpregunta',
                                              arguments: {"id": preguntas[i].id});
                                        });
                                      } else {
                                        Provider.of<Opciones>(context,
                                            listen: false)
                                            .setOpciones(
                                            opciones['respuestascorrectas'],
                                            opciones['opciones'])
                                            .then((Null) {
                                          Navigator.pushNamed(
                                              context, '/editarpregunta',
                                              arguments: {"id": preguntas[i].id});
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_document),
                                        Text("Editar", style: TextStyle(fontSize: 20),),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple),
                                  ))
                            ],
                          ),
                        )
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
                  child: ElevatedButton(
                    onPressed: () {
                      var id = Provider.of<Auth>(context, listen: false).userId;
                      Provider.of<Lecciones>(context, listen: false)
                          .fetchAndSetLecciones(id)
                          .then((_) {
                        Navigator.pushNamed(context, '/crearpregunta');
                      });
                    },
                    child: Container(
                      width: 175,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.add_comment)),
                          ),
                          Flexible(
                            child: Text(
                              "Crear Pregunta",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              ...preguntasWidget
            ],
          ),
        ),
      ),
    );
  }
}
