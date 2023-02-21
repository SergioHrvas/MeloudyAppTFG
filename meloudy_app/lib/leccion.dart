import 'package:flutter/material.dart';

class Leccion extends StatelessWidget {
  final String _texto;
  Leccion(this._texto);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            Container(
                height: 130,
                width: 130,
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 179, 179, 179),
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/musica.png'),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                _texto,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 101, 168, 255)),
            )
          ],
        ),
      ),
    );
  }
}
