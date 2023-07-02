
import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/tarjeta_login.dart';
import 'package:meloudy_app/widget/drawer_app.dart';

class PantallaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("MELOUDY")),
        drawer: DrawerApp(),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(117, 234, 255, 1.0).withOpacity(0.5),
                  Color.fromRGBO(115, 100, 200, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue.shade700,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        "MELOUDY",
                        key: Key('titulo'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 2,
                    child: TarjetaLogin(),
                  )
                ],
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(top: 5),
            ),
          ),
        ]));
  }
}
