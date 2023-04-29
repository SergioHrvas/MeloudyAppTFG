import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/opciones.dart';



class SubirOpcion extends StatefulWidget{

  var datos;
  var indice;
  final f;
  final tipo;

  SubirOpcion(this.indice, this.tipo, this.f, this.datos);

  void cambiarIndice(i){
    print("CAMBIO");
    indice = i;
  }

  @override
  _SubirOpcionState createState() =>
      _SubirOpcionState(this.indice, this.tipo, this.f, this.datos, "Introduzca el texto de la opción");
}

class _SubirOpcionState extends State<SubirOpcion>{
  var indice;
  var f;
  var tipo;
  var etiqueta;
  var datos = "";
  var correcta = false;
var lista;

  _SubirOpcionState(ind, tip, borrar, texto, et){
    indice = ind;
    f = borrar;
    datos = texto;
    etiqueta = et;
    tipo = tip;
  }



  @override
  Widget build(BuildContext context) {
    print(indice);
    lista = Provider.of<Opciones>(context, listen: true).items;

    print("INDIC:" + indice.toString());
     return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Introduzca el título del apartado"),
            maxLines: 1,
            initialValue: this.datos,
            onChanged: (value){
              widget.datos = value;
              Provider.of<Opciones>(context, listen: false).setValorTexto(indice, value);
            },

          ),
          Row(
            children: [
              Text("Correcta: ", style: TextStyle(fontSize: 20),),
              Checkbox(
                value: lista[indice],
                onChanged: (bool value) {
                  setState(() {
                    Provider.of<Opciones>(context, listen: false).setValor(indice, tipo);
                  });
                },
              ),
            ],
          ), //Checkbox
          GestureDetector(onTap: (){
            f(indice);

          },child: Icon(Icons.delete_forever, size: 40, color:Colors.red,))
        ],
      ),
    );
  }

}