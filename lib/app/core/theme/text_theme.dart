import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppju/app/core/values/colors.dart';

TextStyle gfont = GoogleFonts.nunitoSans(fontSize: 15.5, color: C.black7);

class Gfont {
  static final white = gfont.copyWith(color: C.white);
  static final orange = gfont.copyWith(color: C.orange);
  static final blue = gfont.copyWith(color: C.blue);
  static final red = gfont.copyWith(color: C.red);
  static final green = gfont.copyWith(color: C.green);
  static final black3 = gfont.copyWith(color: C.black3);
  static final black4 = gfont.copyWith(color: C.black4);
  static final black5 = gfont.copyWith(color: C.black5);
  static final black6 = gfont.copyWith(color: C.black6);
  static final black7 = gfont.copyWith(color: C.black7);

  // size
  static final fs13 = gfont.copyWith(fontSize: 13);
  static final fs14 = gfont.copyWith(fontSize: 14);
  static final fs15 = gfont.copyWith(fontSize: 15);
  static final fs16 = gfont.copyWith(fontSize: 16);
  static final fs17 = gfont.copyWith(fontSize: 17);
  static final fs18 = gfont.copyWith(fontSize: 18);
  static final fs19 = gfont.copyWith(fontSize: 19);
  static final fs20 = gfont.copyWith(fontSize: 20);
  static fs(double size) => gfont.copyWith(fontSize: size);

  static final bold =
      gfont.copyWith(fontWeight: FontWeight.bold, color: C.black7);
  static boldWith([Color color = C.black7, double size = 15.5]) =>
      gfont.copyWith(fontWeight: FontWeight.bold, color: color, fontSize: size);
}
