import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../modo.dart';
import '../providers/logros.dart';
import '../widget/pregunta_widget.dart';

class PantallaUsuario extends StatelessWidget {
  static const routeName = '/usuario';

  var usuario;
  var nombre;

  var logros = [];
  @override
  Widget build(BuildContext context) {
    usuario = Provider.of<UsuarioPerfil>(context, listen: false).item;
    nombre = usuario.nombre +
        " " +
        usuario.apellidos[0] +
        " " +
        usuario.apellidos[1];

    for(var i = 0; i < min(usuario.logros.length, 6); i++){
      logros.add(Container(
          margin: EdgeInsets.only(right: 5),
          width: 50,
          child: GestureDetector(
            onTap: (){
              Provider.of<Logros>(context,listen: false).getLogro(usuario.logros[i].id).then((value){
                print(value.nombre);
                Navigator.pushNamed(context, '/logro', arguments: value);

              });
            },
              child: MODO.modo != 1 ? Image.network("http://${IP.ip}:5000/img/${usuario.logros[i].imagen}") : Container())),);
    /*Container(
    width: 50,
    child: Image.network("http://${IP.ip}:5000/img/2.png")),
    Container(
    width: 50,
    child: Image.network("http://${IP.ip}:5000/img/13.png")),
    Container(
    width: 50,
    child: Image.network("http://${IP.ip}:5000/img/19.png")),
    Container(
    width: 50,
    child: Image.network("http://${IP.ip}:5000/img/24.png")),*/

    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi perfil"),
        ),
        drawer: DrawerApp(),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MODO.modo != 1 ? NetworkImage(
                                "http://${IP.ip}:5000/img/${usuario.foto}") : AssetImage('assets/musica.png'))),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            child: Text(
                              nombre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.fade,
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "@" + usuario.username,
                              key: Key('userNameFinal'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey),
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              usuario.rol,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: usuario.rol == "Admin"
                                      ? Colors.red
                                      : usuario.rol == "Profesor"
                                          ? Colors.green
                                          : Colors.blue),
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),

                            child: Text(
                          usuario.correo,
                          style: TextStyle(fontSize: 20),
                        )),
                        Container(
                          width: 130,
                          child: ElevatedButton(
                              key: Key('editarperfil'),
                              onPressed: () {
                                Navigator.pushNamed(context, '/editarperfil', arguments: {
                                "id": usuario.id.toString()
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: Icon(Icons.edit)),
                                  ),
                                  Flexible(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 3),
                                        child: Text("Editar", style: TextStyle(fontSize: 20),)),
                                  )
                                ],
                              )),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text("Mis Logros", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                          Row(
                              children: [
                            ...logros
                          ]),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ElevatedButton(onPressed: (){
                              Navigator.pushNamed(context, '/listalogros');
                            }, child: Text("Más")),
                          )
                        ],
                      )),
                ],
              )),
        ));
  }
}
