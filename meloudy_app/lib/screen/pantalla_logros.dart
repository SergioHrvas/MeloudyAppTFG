import 'package:flutter/material.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/logros.dart';
import 'package:meloudy_app/extensiones.dart';
import '../widget/drawer_app.dart';

class PantallaLogros extends StatefulWidget {
  static const routeName = '/listalogros';

  @override
  _PantallaLogrosState createState() =>
      _PantallaLogrosState();
}

class _PantallaLogrosState extends State<PantallaLogros> {
  _PantallaLogrosState();

  var logros = [];


  @override
  Widget build(BuildContext context) {
    var usuario =
        Provider.of<UsuarioPerfil>(context, listen: false).item;

    var logros = usuario.logros;


    var logrosWidget = [];
    for (var i = 0; i < logros.length; i++) {
      logrosWidget.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(124, 135, 255, 0.615686274509804),),        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                child: Container(                decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(200)),
                    child: Image.network('http://${IP.ip}:5000/img/${logros[i].imagen}',))
              ),
              Container(
                child: Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),

                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 15, bottom: 10),
                            child: Text(logros[i].nombre.toString().useCorrectEllipsis(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, overflow: TextOverflow.ellipsis), maxLines: 1,),
                            ),
                        Container(
                          margin: EdgeInsets.only(left: 15,bottom: 10),
                          child: Text(logros[i].descripcion, style: TextStyle(fontSize: 16),)
                          ,
                        ),
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
      appBar: AppBar(          title: Text("Lista de logros"),
      ),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...logrosWidget,
            Container(margin: EdgeInsets.only(bottom: 20),)],

          ),
        ),
      ),
    );
  }
}
