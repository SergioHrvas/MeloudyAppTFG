import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/opciones.dart';


class SubirOpcion extends StatelessWidget{
  var datos;
  var indice;
  final f;
  final tipo;

  SubirOpcion(this.indice, this.tipo, this.f, this.datos);
  void cambiarIndice(i) {
    indice = i;
  }

  Widget build(BuildContext context){
    return Column(children: [SubirOpcionFul(indice, tipo, datos),
      GestureDetector(
    onTap: () {
      f(indice);
    },
    child: Icon(
    Icons.delete_forever,
    size: 40,
    color: Colors.red,
    ))
  ]);
  }

}


class SubirOpcionFul extends StatefulWidget {
  var datos;
  var indice;
  final tipo;

  SubirOpcionFul(this.indice, this.tipo, this.datos);


  @override
  _SubirOpcionFulState createState() => _SubirOpcionFulState(this.indice, this.tipo,
    this.datos, "Introduzca el texto de la opción");
}

class _SubirOpcionFulState extends State<SubirOpcionFul> {
  var indice;
  var tipo;
  var etiqueta;
  var datos = "";
  var correcta = false;
  var lista;

  _SubirOpcionFulState(ind, tip, texto, et) {
    indice = ind;
    datos = texto;
    etiqueta = et;
    tipo = tip;
  }

  @override
  Widget build(BuildContext context) {
    lista = Provider.of<Opciones>(context, listen: true).items;

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: "Introduzca la respuesta"),
            maxLines: 1,
            initialValue: this.datos,
            onChanged: (value) {
              widget.datos = value;
              Provider.of<Opciones>(context, listen: false)
                  .setValorTexto(indice, value);
            },
          ),
          Row(
            children: [
              Text(
                "Correcta: ",
                style: TextStyle(fontSize: 20),
              ),
              Checkbox(
                value: lista[indice],
                onChanged: (bool value) {
                  setState(() {
                    Provider.of<Opciones>(context, listen: false)
                        .setValor(indice, tipo);
                  });
                },
              ),
            ],
          ), //Checkbox

        ],
      ),
    );
  }
}
