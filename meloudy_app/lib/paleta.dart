//palette.dart
import 'package:flutter/material.dart';
class Paleta {
  static const MaterialColor blueCustom = const MaterialColor(
    0xff1683b0, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff14759d ),//10%
      100: const Color(0xff12678a),//20%
      200: const Color(0xff0f5674),//30%
      300: const Color(0xff0d4b65),//40%
      400: const Color(0xff0b4157),//50%
      500: const Color(0xff09374a),//60%
      600: const Color(0xff072b39),//70%
      700: const Color(0xff051e28),//80%
      800: const Color(0xff031217),//90%
      900: const Color(0xff000000),//100%
    },
  );
  static const MaterialColor blueBackground = const MaterialColor(
    0xffc8dde1, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffd8ebf1 ),//10%
      100: const Color(0xffc3d4da),//20%
      200: const Color(0xffa9c2ca),//30%
      300: const Color(0xff95b2bb),//40%
      400: const Color(0xff72929b),//50%
      500: const Color(0xff58777f),//60%
      600: const Color(0xff48656c),//70%
      700: const Color(0xff334b50),//80%
      800: const Color(0xff1d2d30),//90%
      900: const Color(0xff000000),//100%
    },
  );
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below.