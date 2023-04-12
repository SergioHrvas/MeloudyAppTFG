import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubirTexto extends StatelessWidget{

  var indice;
  var f;
  final tipo = "texto";
  var datos = "";

  SubirTexto(ind, borrar, texto){
  indice = ind;
  f = borrar;
  datos = texto;
}

void cambiarIndice(i){
  indice = i;
}

  @override
Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 30),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Introduzca el texto de la lección"),
            maxLines: 10,
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