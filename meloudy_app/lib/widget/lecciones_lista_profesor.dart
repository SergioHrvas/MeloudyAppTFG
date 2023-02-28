import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/lecciones.dart';
import './leccion_item_profesor.dart';

class LeccionesListaProfesor extends StatefulWidget {
  @override
  _LeccionesListaProfesorState createState() => _LeccionesListaProfesorState();
}

class _LeccionesListaProfesorState extends State<LeccionesListaProfesor> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Lecciones>(context).fetchAndSetProducts().then((_) {
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
          child: LeccionItemProfesor(
            // products[i].id,
            lecciones[i].nombre,
            lecciones[i].contenido,
            lecciones[i].imagenprincipal,
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
