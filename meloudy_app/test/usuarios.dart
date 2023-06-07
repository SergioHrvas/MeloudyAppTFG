import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/usuarios.dart';
import 'package:provider/provider.dart';

void main() async{

  test('Los usuarios deben obtenerse y guardarse en el vector del provider', () async {
    
    final c = Usuarios();
    var id = "63fe53c56ac25d3aa7ac988b";
    await c.fetchAndSetUsers();

    expect(c.usuarios.length, greaterThanOrEqualTo(1));
  });

}