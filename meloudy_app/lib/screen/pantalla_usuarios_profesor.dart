import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../extensiones.dart';
import '../modo.dart';
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

  var usuarios = [];

  showAlertDialog(BuildContext context, id, i) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("Borrar"),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        setState(() {
          usuarios.removeAt(i);
        });

        Provider.of<Usuarios>(context, listen: false).borrarUsuario(id)
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
      title: Text("¿Desea eliminar el usuario?"),
      content: Text(
          "Pulse \"Confirmar\" si desea eliminarlo. En caso contrario pulse \"Cancelar\"."),
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
    usuarios =
        Provider.of<Usuarios>(context, listen: false).items;

    var usuariosWidget = [];
    for (var i = 0; i < usuarios.length; i++) {
      var nombre = usuarios[i].nombre + " " + usuarios[i].apellidos[0] + " " + usuarios[i].apellidos[1];

      usuariosWidget.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(124, 135, 255, 0.615686274509804),),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MODO.modo != 1 ? NetworkImage('http://${IP.ip}:5000/img/${usuarios[i].foto}') : AssetImage('assets/musica.png'),
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

                    child: Text(nombre.toString().useCorrectEllipsis(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, overflow: TextOverflow.ellipsis), maxLines: 1,),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.center,
                            child: Text(usuarios[i].correo.toString(), style: TextStyle(fontSize: 18,color: Color.fromRGBO(50, 50, 50, 1)),)),
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
                                      showAlertDialog(context, usuarios[i].id, i);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        Text("Borrar",style: TextStyle(fontSize: 20),),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/editarusuario', arguments: {
                                      "id": usuarios[i].id.toString()
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_document),
                                        Text("Editar",style: TextStyle(fontSize: 20),),
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
                  child: ElevatedButton(onPressed:(){
                    Navigator.pushNamed(context, '/crearusuario');
                  },
                    child: Container(
                      width: 175,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.person_add))),
                          Flexible(child: Text("Crear Usuario",style: TextStyle(fontSize: 20),)),
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
