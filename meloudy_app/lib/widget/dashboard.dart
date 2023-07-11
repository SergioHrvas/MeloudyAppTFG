import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/logros.dart';
import '../providers/preguntas_profesor.dart';
import '../providers/usuario_perfil.dart';
import '../providers/usuarios.dart';
import '../screen/pantalla_lecciones_profesor.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    primary: Colors.black45,
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
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(220, 50),
                      primary: Colors.black45,
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
                        Text("Preguntas", style: TextStyle(fontSize: 25)),
                      ],
                    ))),
            Provider.of<Auth>(context, listen: false).getRol == 'Admin' ?  Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(220, 50),
                      primary: Colors.black45,
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
                        Text("Usuarios",                  key: Key('usuarios'),
                            style: TextStyle(fontSize: 25)),
                      ],
                    )))
            : Container(),
            Provider.of<Auth>(context, listen: false).getRol == 'Admin' ?  Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(220, 50),
                      primary: Colors.black45,
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                    ),
                    onPressed: () {
                      Provider.of<Logros>(context, listen: false)
                          .fetchAndSetLogros()
                          .then((_) {
                        Navigator.pushNamed(context, '/listalogrosprofesor');
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
                        Text("Logros", style: TextStyle(fontSize: 25)),
                      ],
                    ))) : Container(),
          ],
        ));
  }
}
