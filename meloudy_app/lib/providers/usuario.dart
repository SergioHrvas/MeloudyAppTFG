import 'package:flutter/foundation.dart';
import 'package:meloudy_app/providers/test.dart';


class Usuario with ChangeNotifier {
  final String id;
  final String nombre;


  List<Test> tests = [];

  Usuario({
    @required this.id,
    @required this.nombre,
  });

}
