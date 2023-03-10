import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/preguntas.dart';
class OpcionBoton extends StatefulWidget{

  final _texto;
  final _num;
  final _color;
  OpcionBoton(this._texto, this._num, this._color);

  @override
  _OpcionBotonState createState() => _OpcionBotonState(_texto, _num, _color);
}

class _OpcionBotonState extends State{
  var _pulsado = false;
  var _texto;
  var _num;
  var _color;
  var _modo;

  _OpcionBotonState(this._texto, this._num, this._color);


  @override
  void initState() {
    super.initState();
  }

  Widget build(context){
    _pulsado = Provider.of<Preguntas>(context, listen: false).getPulsado(_num);
    _modo = Provider.of<Preguntas>(context, listen: false).modo;
    print("NUM: " + _num.toString());
    print("COLOR:" + _color.toString());
    print("modo:" + _modo.toString());
    return Container(
        width: 180,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: (_modo == 'respondiendo') ? _pulsado ? Color.fromRGBO(50, 100, 250, 1): Color.fromRGBO(50, 200, 250, 1) : (_color=='verde') ? Colors.green : (_color=='rojo') ? Colors.red : Colors.blue),
            onPressed: () {
              setState(() {
                _pulsado = !_pulsado;
                Provider.of<Preguntas>(context, listen: false).setPulsado(_num);

                Provider.of<Preguntas>(context, listen: false).setRespuestas(_num.toString());
              });
            },
            child: Text(_texto)));
  }
}