import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/preguntas_profesor.dart';
import '../providers/usuarios.dart';
import '../widget/drawer_app.dart';

class PantallaUsuariosProfesor extends StatefulWidget {
  static const routeName = '/listausuarios';

  @override
  _PantallaUsuariosProfesorState createState() =>
      _PantallaUsuariosProfesorState();
}

class _PantallaUsuariosProfesorState extends State<PantallaUsuariosProfesor> {
  _PantallaUsuariosProfesorState();

  @override
  Widget build(BuildContext context) {
    var usuarios =
        Provider.of<Usuarios>(context, listen: false).items;

    var usuariosWidget = [];
    for (var i = 0; i < usuarios.length; i++) {
      usuariosWidget.add(Container(
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
                    image: NetworkImage('http://${IP.ip}:5000/img/${usuarios[i].foto}'),
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
                                Expanded(child: Row(children: [
                                  Text(usuarios[i].nombre + " ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  Text(usuarios[i].apellidos[0] + " ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  Text(usuarios[i].apellidos[1], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ]
                  )),
                                Container(margin: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.edit_document, color: Colors.blue))
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("" + usuarios[i].id, style: TextStyle(color: Colors.grey),)),

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
                    Navigator.pushNamed(context, '/crearUsuario');
                  },
                    child: Container(
                      width: 175,
                      child: Row(
                        children: [
                          Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.add_comment)),
                          Text("Crear Usuario",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),)),
              ...usuariosWidget],
          ),
        ),
      ),
    );
  }
}
