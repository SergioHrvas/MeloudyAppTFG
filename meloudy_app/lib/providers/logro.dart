import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';


class Logro with ChangeNotifier {
  final String id;
  String nombre;
  String descripcion;
  String imagen;
  String tipo;
  dynamic condicion;

  Logro({
    @required this.id,
    @required this.nombre,
    @required this.descripcion,
    @required this.imagen,
    @required this.tipo,
    @required this.condicion
  });

}
