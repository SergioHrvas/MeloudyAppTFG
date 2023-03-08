import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/preguntas.dart';
class OpcionBoton extends StatefulWidget{

  final _texto;
  final _num;
  OpcionBoton(this._texto, this._num);

  @override
  _OpcionBotonState createState() => _OpcionBotonState(_texto, _num);
}

class _OpcionBotonState extends State{
  var _pulsado = false;
  var _texto;
  var _num;

  _OpcionBotonState(this._texto, this._num);


  @override
  void initState() {
    super.initState();
  }

  Widget build(context){

    _pulsado = Provider.of<Preguntas>(context, listen: false).getPulsado(_num);

    print("PULSADO: " + _pulsado.toString());
    return Container(
        width: 180,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: _pulsado ? Color.fromRGBO(50, 100, 250, 1): Color.fromRGBO(50, 200, 250, 1)),
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