import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/pregunta.dart';
import 'package:provider/provider.dart';

import 'auth.dart';



class Test with ChangeNotifier {
  final String id;
  final String fecha_creacion;
  final int aciertos;

  Test({
  @required this.id,
  @required this.fecha_creacion,
  @required this.aciertos
  });
}