import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:provider/provider.dart';

void main() async{
  test('Las lecciones deben obtenerse y guardarse en el vector del provider', () async {
    final c = Lecciones();

    var id = "63fe53c56ac25d3aa7ac988b";

    await c.fetchAndSetLecciones(id);


    expect(c.lecciones.length, greaterThanOrEqualTo(1));
  });
}