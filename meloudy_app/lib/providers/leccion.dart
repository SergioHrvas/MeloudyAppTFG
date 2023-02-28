import 'package:flutter/foundation.dart';

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

  Leccion({
    @required this.id,
    @required this.nombre,
    @required this.contenido,
    @required this.imagenprincipal
  });
}
