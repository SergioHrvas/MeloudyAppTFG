import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';


class Logro with ChangeNotifier {
  final String id;
  final String nombre;
  final String descripcion;
  final String imagen;


  Logro({
    @required this.id,
    @required this.nombre,
    @required this.descripcion,
    @required this.imagen,
  });

}
