import 'package:flutter/material.dart';

class Pregunta with ChangeNotifier {
  final String id;
  final String cuestion;
  final String tipo;
  final List<String> opciones;
  List<String> respuestascorrectas = [];
  final String imagen;
  List<String> respuestas = [];
  List <bool> pulsado = [];
  final String leccion;

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