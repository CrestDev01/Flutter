// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import 'base_text_style.dart';

class BaseInputDecoration extends InputDecoration {
  final String? hintText_;
  final double? hintFontSize;
  final Widget? suffixIcon_;
  final Color? fillColor_;
  final Color? borderColor;
  final Color? hintTextColor;
  final Widget? prefixIcon_;
  final BorderRadius? borderRadius;
  double borderWidth = 1;
  bool isDense_ = false;
  final EdgeInsetsGeometry? contentPadding_;
  String counterText_ = "";
  final BuildContext context;
  final FontWeight? fontWeight;
  final TextStyle? labelStyle_;
  bool? isFloating = false;
  final Color? colorErrorText;
  bool isHelperVisible = true;
  String helperText_ = " ";
  bool isTaskHintShow = false;
  AutovalidateMode? autoValidateMode;

  BaseInputDecoration(
    this.context, {
    this.prefixIcon_,
    this.fillColor_,
    this.suffixIcon_,
    this.isHelperVisible = true,
    this.helperText_ = " ",
    this.isDense_ = false,
    this.borderRadius,
    this.borderWidth = 1,
    this.borderColor,
    this.contentPadding_,
    this.hintText_,
    this.isTaskHintShow = false,
    this.hintFontSize,
    this.fontWeight,
    this.hintTextColor,
    this.counterText_ = "",
    this.colorErrorText,
    this.isFloating = false,
    this.labelStyle_,
  }) : super(
          errorMaxLines: 2,
          prefixIcon: prefixIcon_,
          // prefixIconConstraints: BoxConstraints.tight(Size(36, 24)),
          fillColor: fillColor_ ?? ColorsUtils.colorWhite.withOpacity(0.3),
          filled: true,
          suffixIcon: suffixIcon_,
          helperText: (isHelperVisible) ? helperText_ : null,
          helperStyle:
              const TextStyle(height: 0.5, color: ColorsUtils.colorWhite),
          suffixIconConstraints: isDense_
              ? const BoxConstraints(
                  minWidth: 2,
                  minHeight: 2,
                )
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(dim100),
              borderSide: BorderSide(
                  color: borderColor ?? ColorsUtils.colorLightGrey,
                  width: borderWidth)),
          enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(dim100),
              borderSide: BorderSide(
                  color: borderColor ?? ColorsUtils.colorLightGrey,
                  width: borderWidth)),
          border: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(dim100),
              borderSide: BorderSide(
                  color: borderColor ?? ColorsUtils.colorLightGrey,
                  width: borderWidth)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(dim100),
              borderSide: BorderSide(
                  color: borderColor ?? ColorsUtils.colorLightGrey,
                  width: borderWidth)),
          contentPadding: contentPadding_ ??
              const EdgeInsets.symmetric(vertical: 0, horizontal: dim14),
          isDense: isDense_,
          hintText: hintText_,
          hintMaxLines: (isTaskHintShow) ? 5 : 1,
          hintStyle: TextStyle(
              fontSize: hintFontSize ?? dim16,
              fontWeight: fontWeight ?? FontWeight.normal,
              letterSpacing: 0,
              color: hintTextColor ?? ColorsUtils.colorBlack.withOpacity(0.5)),
          counterText: counterText_,
          errorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(dim100),
              borderSide:
                  const BorderSide(color: ColorsUtils.colorRed, width: dim1)),
          errorStyle: BaseTextStyle(
            height: 1,
            color: colorErrorText ?? ColorsUtils.colorRed,
            fontSize: dim14,
          ),
          labelText: isFloating! ? hintText_ : null,
          labelStyle: labelStyle_ ??
              const TextStyle(
                color: ColorsUtils.colorBlack,
                fontSize: dim14,
              ),
        );
}
