// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import 'base_text_style.dart';

class BaseText extends Text {
  final String? text;
  final Color color;
  @override
  final TextAlign textAlign;
  final double fontSize;
  final double letterSpacing;
  final double? wordSpacing;
  final TextOverflow? textOverflow;
  final TextDecoration textDecoration;
  @override
  final int? maxLines;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final MyFont myFont;
  final double? height;

  BaseText(
      {super.key,
      required this.text,
      this.color = ColorsUtils.colorBlack,
      this.fontSize = dim16,
      this.textAlign = TextAlign.start,
      this.textOverflow,
      this.textDecoration = TextDecoration.none,
      this.maxLines,
      this.letterSpacing = 0.0,
      this.wordSpacing,
      this.fontStyle,
      this.fontWeight,
      this.textStyle,
      this.height,
      this.myFont = MyFont.regular})
      : super(text!,
            // textScaleFactor: 0.80,
            textAlign: textAlign,
            overflow: textOverflow ??
                (maxLines == 1 ? TextOverflow.ellipsis : textOverflow),
            maxLines: maxLines,
            style: textStyle ??
                BaseTextStyle(
                    decoration: textDecoration,
                    decorationStyle: TextDecorationStyle.solid,
                    color: color,
                    fontSize: fontSize,
                    fontWeight: myFont.weight,
                    fontStyle: myFont.style,
                    fontFamily: myFont.family,
                    height: height,
                    letterSpacing: letterSpacing,
                    wordSpacing: wordSpacing));
}
