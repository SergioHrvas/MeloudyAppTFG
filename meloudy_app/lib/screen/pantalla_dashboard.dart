import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/lecciones_pantalla_profesor.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../providers/logros.dart';
import '../providers/preguntas_profesor.dart';
import '../providers/usuarios.dart';

class PantallaDashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DASHBOARD"),
        ),
        drawer: DrawerApp(),
        body: Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(220, 50),
                        primary: Colors.purple,
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          LeccionesPantallaProfesor.routeName,
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Icon(
                              Icons.book,
                              size: 35,
                            ),
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          Text(
                            "Lecciones",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(220, 50),
                          primary: Colors.purple,
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                        ),
                        onPressed: () {
                          Provider.of<PreguntasProfesor>(context, listen: false)
                              .fetchAndSetPreguntas()
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, '/listapreguntas');
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Icon(
                                Icons.question_answer,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(bottom: 5),
                            ),
                            Text("Preguntas", style: TextStyle(fontSize: 20)),
                          ],
                        ))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(220, 50),
                          primary: Colors.purple,
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                        ),
                        onPressed: () {
                          Provider.of<Usuarios>(context, listen: false)
                              .fetchAndSetUsers()
                              .then((_) {
                            Navigator.pushNamed(context, '/listausuarios');
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Icon(
                                Icons.people,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(bottom: 5),
                            ),
                            Text("Usuarios", style: TextStyle(fontSize: 20)),
                          ],
                        ))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(220, 50),
                          primary: Colors.purple,
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                        ),
                        onPressed: () {
                          Provider.of<Logros>(context, listen: false)
                              .fetchAndSetLogros()
                              .then((_) {
                            Navigator.pushNamed(context, '/listalogros');
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Icon(
                                Icons.workspace_premium,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(bottom: 5),
                            ),
                            Text("Logros", style: TextStyle(fontSize: 20)),
                          ],
                        ))),
              ],
            )));
  }
}
