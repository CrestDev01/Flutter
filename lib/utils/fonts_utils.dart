import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'dimensions_utils.dart';

/*
w100 Thin, the least thick
w200 Extra-light
w300 Light
w400 Normal / regular / plain
w500 Medium
w600 Semi-bold
w700 Bold
w800 Extra-bold
w900 Black, the most thick
*/

const String fontFamilyName = 'Poppins';

enum MyFont {
  thin,
  extraLight,
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
  black,
  italic,
  boldItalic
}

extension ExtMyFont on MyFont {
  String get family {
    switch (this) {
      case MyFont.regular:
        return fontFamilyName;
      default:
        return fontFamilyName;
    }
  }

  FontStyle get style {
    switch (this) {
      case MyFont.italic:
      case MyFont.boldItalic:
        return FontStyle.italic;
      default:
        return FontStyle.normal;
    }
  }

  FontWeight get weight {
    switch (this) {
      case MyFont.thin:
        return FontWeight.w100;
      case MyFont.extraLight:
        return FontWeight.w200;
      case MyFont.light:
        return FontWeight.w300;
      case MyFont.regular:
        return FontWeight.w400;
      case MyFont.medium:
        return FontWeight.w500;
      case MyFont.semiBold:
        return FontWeight.w600;
      case MyFont.bold:
        return FontWeight.w700;
      case MyFont.extraBold:
        return FontWeight.w800;
      case MyFont.black:
        return FontWeight.w900;
      case MyFont.italic:
        return FontWeight.w400;
      case MyFont.boldItalic:
        return FontWeight.w700;
    }
  }
}

extension TextStyleExt on TextStyle {
  static TextStyle getTextStyleWithFont(
      {MyFont myFont = MyFont.regular, double fontSize = dim17, Color? color}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: myFont.family,
      fontWeight: myFont.weight,
      fontStyle: myFont.style,
    );
  }
}
