import 'package:flutter/material.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../widget/pregunta_widget.dart';

class PantallaUsuario extends StatelessWidget {
  static const routeName = '/usuario';

  var usuario;
  var nombre;

  @override
  Widget build(BuildContext context) {
    usuario = Provider.of<UsuarioPerfil>(context, listen: false).item;
    nombre = usuario.nombre +
        " " +
        usuario.apellidos[0] +
        " " +
        usuario.apellidos[1];

    return Scaffold(
        appBar: AppBar(
          title: Text("Mi perfil"),
        ),
        drawer: DrawerApp(),
        body: Container(
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
                          image: NetworkImage(
                              "http://${IP.ip}:5000/img/${usuario.foto}"))),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/editarusuario', arguments: {
                              "id": usuario.id.toString()
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(Icons.edit)),
                                Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text("Editar"))
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
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("Mis Logros", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Container(
                              width: 50,
                              child: Image.network("http://${IP.ip}:5000/img/1.png")),
                          Container(
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
                              child: Image.network("http://${IP.ip}:5000/img/24.png")),

                        ]),
                      ],
                    )),
              ],
            )));
  }
}
