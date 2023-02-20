import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meloudy_app/leccion.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;



class Login extends StatelessWidget {

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("MELOUDY")),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text("sadasdadasd"),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    title: Text("Item 1"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top:5),
                    child: Column(
              children: [Container(child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                    labelText: "Correo Electrónico"
                ),
              ),
              margin: EdgeInsets.only(bottom: 20),), TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Contraseña"
                ),
                obscureText: true,
              ),
              ElevatedButton(
                child: Text("Iniciar Sesión"),
              )]
            )))));
  }

}
