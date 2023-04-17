import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';


class Usuario with ChangeNotifier {
  final String id;
  final String nombre;
  final String apellidos;
  final String username;
  final String imagen;
  final String correo;


  List<Test> tests = [];

  Usuario({
    @required this.id,
    @required this.nombre,
    @required this.apellidos,
    @required this.correo,
    @required this.username,
    @required this.imagen,

  });

}
