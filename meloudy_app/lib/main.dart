import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("MELOUDY"),
          ),
          body: Column(
            children: [
              Text("Hola"),
              Text("esto"),
              Text("es"),
              Text("una"),
              Text("aplicación"),
              Text("de"),
              Text("flutter"),
            ],
          )),
    );
  }
}
