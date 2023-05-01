import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/notas.dart';

class SubirNotas extends StatelessWidget {
  var indice;
  final f;
  var datos = "";
  var widget;

  SubirNotas(this.indice, this.f, this.datos);

  void cambiarIndice(i) {
    indice = i;
  }

  @override
  Widget build(BuildContext context) {
    widget = Column(
      children: [
        SubirNotasFul(this.datos, this.indice),
        GestureDetector(
            onTap: () {
              f(indice);
            },
            child: Icon(
              Icons.delete_forever,
              size: 40,
              color: Colors.red,
            ))
      ],
    );
    return widget;
  }
}

class SubirNotasFul extends StatefulWidget {
  var indice;
  final datos;

  void cambiarIndice(i) {
    indice = i;
  }

  SubirNotasFul(this.datos, this.indice);

  @override
  _SubirNotasState createState() => _SubirNotasState(this.datos, this.indice);
}

class _SubirNotasState extends State<SubirNotasFul> {
  final indice;
  var nota = "Do";
  final notas = ["Do", "Re", "Mi", "Fa", "Sol", "La", "Si"];

  _SubirNotasState(this.nota, this.indice);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    nota = Provider.of<Notas>(context, listen: false).getNota(indice);

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                  items: notas.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: nota,
                  onChanged: (String newvalue) {
                    setState(() {
                      nota = newvalue;
                      Provider.of<Notas>(context, listen: false)
                          .setValor(indice, nota);
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
