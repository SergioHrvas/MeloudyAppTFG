import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubirTitulo extends StatelessWidget{
  var indice;
  var f;
  final tipo = "titulo";
  var datos = "";


  SubirTitulo(ind, borrar, texto){
    indice = ind;
    f = borrar;
    datos = texto;
  }

  void cambiarIndice(i){
    indice = i;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Introduzca el título del apartado"),
            maxLines: 1,
            initialValue: this.datos,
            onChanged: (value){
              datos = value;
            },

          ),
          GestureDetector(onTap: (){
            f(indice);

          },child: Icon(Icons.delete_forever, size: 40, color:Colors.red,))
        ],
      ),
    );
  }

}