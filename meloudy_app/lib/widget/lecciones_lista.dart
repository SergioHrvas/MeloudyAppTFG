import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/lecciones.dart';
import './leccion_item.dart';

class LeccionesLista extends StatefulWidget {
  @override
  _LeccionesListaState createState() => _LeccionesListaState();
}

class _LeccionesListaState extends State<LeccionesLista> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetLecciones(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetLecciones();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      var id = Provider.of<Auth>(context).userId;

        Provider.of<Lecciones>(context).fetchAndSetLecciones(id).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final leccionesData = Provider.of<Lecciones>(context);
    final lecciones = leccionesData.items;
    var child = new List<Widget>();
    for (var i = 0; i < lecciones.length; i++) {
      child.add(
        ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: lecciones[i],
          child: LeccionItem(
            // products[i].id,
            lecciones[i].nombre,
            lecciones[i].contenido,
            lecciones[i].imagenprincipal,
            lecciones[i].estado
            // products[i].imageUrl,
          ),
        ),
      );
    }
    return Column(
      children: child,
    );
  }
}
