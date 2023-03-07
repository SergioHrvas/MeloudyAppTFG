import 'package:flutter/material.dart';

class Pregunta with ChangeNotifier {
  final String id;
  final String cuestion;
  final String tipo;
  final List<String> opciones;
  final List<String> respuestascorrectas;
  final String imagen;
  List<String> respuestas = [];

  Pregunta({
    @required this.id,
    @required this.cuestion,
    @required this.tipo,
    @required this.opciones,
    @required this.respuestascorrectas,
    @required this.imagen
  });

}