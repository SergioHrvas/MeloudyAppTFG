import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/leccion.dart';
import 'package:meloudy_app/screen/leccion_pantalla.dart';

import '../providers/preguntas.dart';

class LeccionItem extends StatelessWidget {
  final String _nombre;
  final List<Contenido> _contenido;
  final String _imagenprincipal;
  final String _estado;
  LeccionItem(this._nombre, this._contenido, this._imagenprincipal, this._estado);

  @override
  Widget build(BuildContext context) {
    final leccion = Provider.of<Leccion>(context, listen: false);
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(20),
      child: Container(
        width: 300,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(bottom: 12.0),
        child: GestureDetector(
            onTap: () {

              if(_estado != 'bloqueado') {
                Provider.of<Preguntas>(context, listen:false).setIdLeccion(leccion.id);
                Provider.of<Preguntas>(context, listen: false)
                    .fetchAndSetPreguntas(leccion.id);
                Navigator.of(context).pushNamed(
                  LeccionPantalla.routeName,
                  arguments: leccion.id,
                );
              }
            },
            child: Row(
          children: [
            Container(
                height: 90,
                width: 90,
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 179, 179, 179),
                    borderRadius: BorderRadius.circular(100)),

                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/${_imagenprincipal}'),
                        )

                      ),
                    )),
          Container(
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(10),
                width: 190,
                child: Text(
                  _nombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _estado == 'completado' ? Colors.green : _estado == 'desbloqueado' ? Color.fromARGB(255, 101, 168, 255) : Colors.grey),
              ),
          ],
        ),
      ),
      ),
    );
  }
}
