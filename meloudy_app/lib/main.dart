
import 'package:meloudy_app/lecciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meloudy_app/login.dart';
import 'package:meloudy_app/providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
        child: Consumer<Auth>(builder: (ctx, auth, _) => MaterialApp(
          title: 'Meloudy',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth ? Lecciones() : Login(),
        ),),);
  }

}
