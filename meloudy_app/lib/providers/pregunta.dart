import 'package:flutter/material.dart';

class Pregunta with ChangeNotifier {
  final String id;
  String cuestion;
  final String tipo;
  List<dynamic> opciones;
  List<dynamic> respuestascorrectas = [];
  String imagen;
  List<String> respuestas = [];
  List <bool> pulsado = [];
  String leccion;

  Pregunta({
    @required this.id,
    @required this.cuestion,
    @required this.tipo,
    @required this.opciones,
    @required this.respuestascorrectas,
    @required this.imagen,
    @required this.pulsado,
    @required this.leccion
  });

}