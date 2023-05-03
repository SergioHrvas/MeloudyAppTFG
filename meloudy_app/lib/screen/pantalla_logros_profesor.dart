import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/logros.dart';
import '../providers/preguntas_profesor.dart';
import '../providers/usuarios.dart';
import '../widget/drawer_app.dart';

class PantallaLogrosProfesor extends StatefulWidget {
  static const routeName = '/listalogros';

  @override
  _PantallaLogrosProfesorState createState() =>
      _PantallaLogrosProfesorState();
}

class _PantallaLogrosProfesorState extends State<PantallaLogrosProfesor> {
  _PantallaLogrosProfesorState();

  var logros = [];

  showAlertDialog(BuildContext context, id, i) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("Borrar"),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        setState(() {
          logros.removeAt(i);
        });

        Provider.of<Usuarios>(context, listen: false).borrarUsuario(id, i)
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
      title: Text("¿Desea eliminar el logro?"),
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
    logros =
        Provider.of<Logros>(context, listen: false).items;

    var logrosWidget = [];
    for (var i = 0; i < logros.length; i++) {
      logrosWidget.add(Container(
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
                    image: NetworkImage('http://${IP.ip}:5000/img/${logros[i].imagen}'),
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
                            child: Text(logros[i].nombre + " ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                        Container(
                          margin: EdgeInsets.only(left: 15,bottom: 10),
                          child: Text(logros[i].descripcion)
                          ,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("" + logros[i].id.toString(), style: TextStyle(color: Colors.grey),)),
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
                                      showAlertDialog(context, logros[i].id, i);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        Text("Borrar"),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/editarlogro', arguments: {
                                      "id": logros[i].id.toString()
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_document),
                                        Text("Editar"),
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
                    Navigator.pushNamed(context, '/crearlogro');
                  },
                    child: Container(
                      width: 150,
                      child: Row(
                        children: [
                          Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.person_add)),
                          Text("Crear Logro",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),)),
              ...logrosWidget],
          ),
        ),
      ),
    );
  }
}
