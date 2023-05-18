import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';

import 'logro.dart';


class Usuario with ChangeNotifier {
  final String id;
  final String nombre;
  final List<String> apellidos;
  final String username;
  final String foto;
  final String correo;
  final String rol;
  final List<Logro> logros;


  List<Test> tests = [];

  Usuario({
    @required this.id,
    @required this.nombre,
    @required this.apellidos,
    @required this.correo,
    @required this.username,
    @required this.foto,
    @required this.rol,
    @required this.logros,

  });

}
