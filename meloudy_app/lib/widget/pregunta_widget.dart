import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/widget/opcion_boton.dart';
import '../providers/lecciones.dart';
import '../providers/pregunta.dart';
import '../providers/preguntas.dart';
import '../screen/TestAcabadoPantalla.dart';

class PreguntaWidget extends StatefulWidget {
  @override
  _PreguntaWidgetState createState() => _PreguntaWidgetState();
}

class _PreguntaWidgetState extends State {
  var _isInit = true;
  var _isLoading = false;
  var _pulsado = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final preguntasData = Provider.of<Preguntas>(context);
    print("aa");
    final preguntas = preguntasData.items;
    final indice = preguntasData.indiceValor;

    final leccionId = ModalRoute.of(context).settings.arguments as String;

    var textovalor;
    if(preguntas[indice].tipo == 'texto'){
      textovalor =  Provider.of<Preguntas>(context, listen:false).getRespuesta();; // is the id!
    }

    final modo = Provider.of<Preguntas>(context, listen:false).modo;
    print(preguntas[indice].respuestascorrectas);
    var color = 'azul';
    List<Widget> opciones = [];
    if (preguntas[indice].tipo == 'unica' ||
        preguntas[indice].tipo == 'multiple') {
      for (int i = 0; i < preguntas[indice].opciones.length; i++) {
          color = 'azul';
         // print(preguntas[indice].respuestas.toString() + '<<<<' + i.toString() + " --- " + preguntas[indice].respuestas.contains(i.toString()).toString());
        if(preguntas[indice].respuestas.contains(i.toString())) {
          print(preguntas[indice].respuestascorrectas.contains(i.toString()));
          if(preguntas[indice].respuestascorrectas.contains(i.toString())){
            color = 'verde';
          }
          else{
            color = 'rojo';
          }

        }
        print(color);


        opciones.add(OpcionBoton(preguntas[indice].opciones[i], i, color));
      }
    } else if (preguntas[indice].tipo == 'texto') {

      opciones.add(Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          initialValue: textovalor,
          onChanged: (texto){
            Provider.of<Preguntas>(context, listen: false).setRespuestas(texto);
          },
          decoration: InputDecoration(labelText: 'Respuesta',
          filled: modo == 'revisando' ? true : false,
          fillColor: modo == 'revisando' ? preguntas[indice].respuestas.length>0 ? preguntas[indice].respuestascorrectas.contains(preguntas[indice].respuestas[0].toLowerCase()) ? Colors.green : Colors.red : Colors.red : Colors.white),
        ),
      ));
    }
    print("PREGUNTAS: " + preguntas.toString());
    print("INDICE; " + indice.toString());
    // TODO: implement build
    return ChangeNotifierProvider.value(
      value: Pregunta(),
      child: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(indice > 0)
                  Container(
                      child: IconButton(
                    iconSize: 60,
                    padding: new EdgeInsets.all(0.0),
                    color: Colors.blue,
                    icon: new Icon(Icons.arrow_circle_left),
                    onPressed: () {
                      if (indice > 0) {
                        Provider.of<Preguntas>(context, listen: false)
                            .preguntaAnterior();

                        Navigator.pushReplacementNamed(context, '/pregunta', arguments: leccionId);
                      }
                    },
                  )),
                  Container(
                      width: 250,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset('assets/${preguntas[indice].imagen}',
                          fit: BoxFit.cover)),
                  if(indice<preguntas.length-1)
                  Container(
                      child: IconButton(
                    iconSize: 60,
                    padding: new EdgeInsets.all(0.0),
                    color: Colors.blue,
                    icon: new Icon(
                      Icons.arrow_circle_right,
                    ),
                    onPressed: () {
                      if (indice < preguntas.length - 1) {
                        Provider.of<Preguntas>(context, listen: false)
                            .siguientePregunta();
                        Navigator.pushReplacementNamed(context, '/pregunta', arguments: leccionId);
                      }
                    },
                  )),


                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(preguntas[indice].cuestion,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24))),
              Column(
                children: [...opciones,
                  if(indice>=preguntas.length-1 && modo == 'respondiendo')
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child: ElevatedButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, TestAcabadoPantalla.routeName, arguments: leccionId);
                      }, child: Text("FINALIZAR"),),),],
              ),
            ],
          )),
    );
  }
}
