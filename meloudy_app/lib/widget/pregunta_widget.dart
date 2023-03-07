import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meloudy_app/widget/opcion_boton.dart';
import '../providers/pregunta.dart';
import '../providers/preguntas.dart';

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

    List<Widget> opciones = [];
    if (preguntas[indice].tipo == 'unica' ||
        preguntas[indice].tipo == 'multiple') {
      for (int i = 0; i < preguntas[indice].opciones.length; i++) {
        opciones.add(OpcionBoton(preguntas[indice].opciones[i], i));
      }
    } else if (preguntas[indice].tipo == 'texto') {
      opciones.add(Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Respuesta'),
          obscureText: true,
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

                        Navigator.pushReplacementNamed(context, '/pregunta');
                      }
                    },
                  )),
                  Container(
                      width: 250,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset('assets/${preguntas[indice].imagen}',
                          fit: BoxFit.cover)),
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
                        Navigator.pushReplacementNamed(context, '/pregunta');
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
                children: opciones,
              ),
            ],
          )),
    );
  }
}
