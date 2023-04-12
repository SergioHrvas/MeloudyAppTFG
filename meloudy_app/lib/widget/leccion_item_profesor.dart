import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ips.dart';
import '../providers/leccion.dart';

import '../providers/lecciones.dart';
import '../screen/leccion_pantalla_profesor.dart';

class LeccionItemProfesor extends StatelessWidget {
  final String _nombre;
  final List<Contenido> _contenido;
  final String _imagenprincipal;
  final int _indice;
  final String _id;
  LeccionItemProfesor(this._nombre, this._contenido, this._imagenprincipal, this._indice, this._id);

  @override
  Widget build(BuildContext context) {
    final leccion = Provider.of<Leccion>(context, listen: false);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black),
        color: Color.fromRGBO(217, 242, 255, 0.4509803921568675),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 179, 179, 179),
                      borderRadius: BorderRadius.circular(100),),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: true ? NetworkImage('http://${IP.ip}:5000/img/${_imagenprincipal}') : AssetImage('assets/${_imagenprincipal}'),
                        )

                    ),
                  )),
              Container(
                width: 230,
                padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 210,


                      child: Text(
                        _indice.toString() + ". " + _nombre,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color.fromARGB(100, 101, 118, 255),),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Container(margin: EdgeInsets.symmetric(horizontal: 4),child: ElevatedButton(onPressed: (){
                          Provider.of<Lecciones>(context, listen: false).borrarLeccion(_id);
                        }, child: Text("Borrar"), style: ElevatedButton.styleFrom(primary: Colors.red),)),
                        Container(margin: EdgeInsets.symmetric(horizontal: 4), child: ElevatedButton(onPressed: (){
                          Navigator.pushNamed(context, '/editarleccion', arguments: {
                            "id": _id
                          });

                        }, child: Text("Editar"), style: ElevatedButton.styleFrom(primary: Colors.purple),))
                      ],),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
