import 'package:flutter/material.dart';
import 'package:meloudy_app/widget/lecciones_lista.dart';
import 'package:meloudy_app/widget/drawer_app.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/lecciones.dart';

class LeccionesPantalla extends StatefulWidget{
  @override _LeccionesPantallaState createState() => _LeccionesPantallaState();

}
class _LeccionesPantallaState extends State<LeccionesPantalla> {
  final lecciones = [];

  _LeccionesPantallaState();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<Lecciones>(context, listen:false).fetchAndSetLecciones(Provider.of<Auth>(context, listen: false).userId), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait its loading...'));
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
              appBar: AppBar(title: Text("MELOUDY")),
              drawer: DrawerApp(),
              body: RefreshIndicator(
                  onRefresh: () async
                  {
                    var id = Provider.of<Auth>(context, listen:false).userId;
                    await Provider.of<Lecciones>(context, listen: false).fetchAndSetLecciones(id);
                  },
                  child: Stack(children:[
                    ListView(),
                    SingleChildScrollView(child: LeccionesLista()),
                  ])),
            );  // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
