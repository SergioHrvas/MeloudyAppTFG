import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/microfono_pregunta.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/widget/opcion_boton.dart';
import '../ips.dart';
import '../providers/lecciones.dart';
import '../providers/pregunta.dart';
import '../providers/preguntas.dart';
import '../screen/pantalla_final_test.dart';

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

    final preguntas = preguntasData.items;
    final indice = preguntasData.indiceValor;

    final leccionId = ModalRoute.of(context).settings.arguments as String;

    var textovalor;
    if(preguntas[indice].tipo == 'texto'){
      textovalor =  Provider.of<Preguntas>(context, listen:false).getRespuesta(); // is the id!
    }

    final modo = Provider.of<Preguntas>(context, listen:false).modo;
    var color = 'azul';
    List<Widget> opciones = [];
    if (preguntas[indice].tipo == 'unica' ||
        preguntas[indice].tipo == 'multiple') {
      for (int i = 0; i < preguntas[indice].opciones.length; i++) {
          color = 'azul';
        if(preguntas[indice].respuestas.contains(i.toString())) {
          if(preguntas[indice].respuestascorrectas.contains(i.toString())){
            color = 'verde';
          }
          else{
            color = 'rojo';
          }

        }
        opciones.add(OpcionBoton(preguntas[indice].opciones[i], i, color));
      }
    } else if (preguntas[indice].tipo == 'texto') {

      opciones.add(Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        key: Key('texto'),
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
    else if (preguntas[indice].tipo == 'microfono'){
      opciones.add(Container(child: MicrofonoPregunta()));
    }

    // TODO: implement build
    return ChangeNotifierProvider.value(
      value: Pregunta(),
      child: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Container(
                        child:  IconButton(
                      iconSize: 60,
                      padding: new EdgeInsets.all(0.0),
                      color: indice > 0 ? Colors.blue : Colors.grey,
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
                        child: Container(
                            child: Image.network('http://${IP.ip}:5000/img/${preguntas[indice].imagen}'))),
                    Container(
                        child: IconButton(
                          key: Key('siguiente'),
                      iconSize: 60,
                      padding: new EdgeInsets.all(0.0),
                      color: indice<preguntas.length-1 ? Colors.blue : Colors.grey,
                      icon: new Icon(
                        Icons.arrow_circle_right,
                      ),
                      onPressed: () {
                        if (indice < preguntas.length - 1) {
                          Provider.of<Preguntas>(context, listen: false)
                              .siguientePregunta();
                          Provider.of<Preguntas>(context, listen: false)
                              .limpiarVariable();
                          Navigator.pushReplacementNamed(context, '/pregunta', arguments: leccionId);

                        }
                      },
                    )),


                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(preguntas[indice].tipo,
                      key: Key('preguntatipo'),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
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
                      key: Key('fin'),
                      child: ElevatedButton(onPressed: (){

                          Navigator.pushReplacementNamed(context, PantallaFinalTest.routeName, arguments: leccionId);
                      }, child: Text("FINALIZAR"),),),],
              ),
            ],
          )),
    );
  }
}
