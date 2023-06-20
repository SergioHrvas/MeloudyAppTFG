import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ips.dart';
import '../modo.dart';
import '../providers/leccion.dart';

import '../providers/lecciones.dart';
import '../extensiones.dart';

class LeccionItemProfesor extends StatelessWidget {
  final String _nombre;
  final List<Contenido> _contenido;
  final String _imagenprincipal;
  final int _indice;
  final String _id;
  LeccionItemProfesor(this._nombre, this._contenido, this._imagenprincipal,
      this._indice, this._id);

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("Borrar"),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        Provider.of<Lecciones>(context, listen: false)
            .borrarLeccion(_id)
            .then((_) {
          Navigator.of(context).pop();
        });
      },
    );

    Widget noButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("¿Desea eliminar la lección?"),
      content: Text(
          "Pulse \"Borrar\" si desea eliminarla. En caso contrario pulse \"Cancelar\"."),
      actions: [
        noButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var nombreleccion = [];
    for(var i = 0; i < _nombre.length; i++){
      nombreleccion.add(_nombre[i]);
    }
    print(_nombre);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(124, 135, 255, 0.615686274509804),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 179, 179, 179),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      /*image: DecorationImage(
                        fit: BoxFit.fill,
                        image: MODO.modo != 1
                            ? NetworkImage(
                                'http://${IP.ip}:5000/img/${_imagenprincipal}')
                            : AssetImage('assets/musica.png'),
                      )*/),
                )),
            Container(
              margin: EdgeInsets.only(left: 5),
              width: 245,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: 230,
                    child: Text(
                      _indice.toString() + ". " + _nombre.useCorrectEllipsis(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: Text("Borrar",style: TextStyle(fontSize: 20)),
                                style:
                                    ElevatedButton.styleFrom(primary: Colors.red),
                              )),
                        ),
                        Flexible(
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/editarleccion',
                                      arguments: {"id": _id});
                                },
                                child: Text("Editar", style: TextStyle(fontSize: 20),),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
