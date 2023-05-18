import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meloudy_app/providers/usuario_perfil.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/logro.dart';
import '../providers/logros.dart';
import '../widget/pregunta_widget.dart';

class PantallaLogro extends StatelessWidget {
  static const routeName = '/logro';

  var logro;

  var logros = [];
  @override
  Widget build(BuildContext context) {
    var logro = ModalRoute.of(context).settings.arguments as Logro; // is the id!
    print(logro.toString());

    return Scaffold(
        appBar: AppBar(
          title: Text(logro.nombre),
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
                              "http://${IP.ip}:5000/img/${logro.imagen}"))),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 25),
                          alignment: Alignment.center,
                          child: Text(
                            logro.nombre,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.fade,
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            logro.descripcion,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey),
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
