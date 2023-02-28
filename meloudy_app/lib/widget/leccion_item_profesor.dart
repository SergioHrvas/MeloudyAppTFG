import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/leccion.dart';

import '../screen/leccion_pantalla_profesor.dart';

class LeccionItemProfesor extends StatelessWidget {
  final String _nombre;
  final List<Contenido> _contenido;
  final String _imagenprincipal;
  LeccionItemProfesor(this._nombre, this._contenido, this._imagenprincipal);

  @override
  Widget build(BuildContext context) {
    final leccion = Provider.of<Leccion>(context, listen: false);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black),
        color: Color.fromRGBO(217, 242, 255, 0.4509803921568675),
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),

      child: GestureDetector(
      onTap: () {
    Navigator.of(context).pushNamed(
    LeccionPantallaProfesor.routeName,
    arguments: leccion.id,
    );
    },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 70,
                  width: 70,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 179, 179, 179),
                      borderRadius: BorderRadius.circular(100),),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Image.asset('assets/${_imagenprincipal}'),
                  )),
              Column(
                children: [
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
                        color: Color.fromARGB(255, 101, 168, 255),),
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                    Container(margin: EdgeInsets.symmetric(horizontal: 4),child: ElevatedButton(onPressed: (){}, child: Text("Borrar"), style: ElevatedButton.styleFrom(primary: Colors.red),)),
                    Container(margin: EdgeInsets.symmetric(horizontal: 4), child: ElevatedButton(onPressed: (){}, child: Text("Modificar"), style: ElevatedButton.styleFrom(primary: Colors.purple),))
                  ],)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
