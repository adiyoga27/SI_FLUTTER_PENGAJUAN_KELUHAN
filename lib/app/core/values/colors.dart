import 'package:flutter/material.dart';

class C {
  static const none = Colors.transparent;
  static const white = Colors.white;
  static const red = Color(0xffff6961);
  static const blue = Color(0xff0275d8);
  static const green = Color(0xff77dd77);
  static const orange = Color(0xffffa500);
  static const cyan = Color(0xffadd8e6);
  static const yellow = Colors.yellow;

  static const black = Color(0xff181A18);
  static const black1 = Color(0xffF1F1F1);
  static const black2 = Color(0xffD4D4D4);
  static const black3 = Color(0xffB9B9B9);
  static const black4 = Color(0xff9E9E9E);
  static const black5 = Color(0xff848484);
  static const black6 = Color(0xff6B6B6B);
  static const black7 = Color(0xff525252);
  static const black8 = Color(0xff3B3B3B);
  static const black9 = Color(0xff262626);

  static const primaryColor = Color.fromARGB(255, 77, 84, 219);
  static const secondaryColor = Color.fromARGB(255, 77, 84, 219);

  /// eg: `C.hex('f5f5f5')`
  static hex(String? code) =>
      Color(code == null ? int.parse('0xffffffff') : int.parse('0xff$code'));
}
