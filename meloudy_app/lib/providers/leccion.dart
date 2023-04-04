import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';

class Contenido {
  String texto;
  String tipo;

  Contenido({this.texto, this.tipo});
}

class Leccion with ChangeNotifier {
  final String id;
  final String nombre;
  // array of json object
  final List<Contenido> contenido;
  final String imagenprincipal;
  final String estado;
  final int num_aprobados;

  List<Test> tests = [];

  Leccion({
    @required this.id,
    @required this.nombre,
    @required this.contenido,
    @required this.imagenprincipal,
    @required this.estado,
    @required this.num_aprobados
  });

  void setTests(testsCargados){
    tests = testsCargados;
  }
}
