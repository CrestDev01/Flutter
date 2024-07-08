import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import 'base_decoration.dart';
import 'base_text_style.dart';

// ignore: must_be_immutable
class BaseTextField extends TextFormField {
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool obscureText;
  final double? fontSize;
  final double? hintFontSize;
  final String? Function(String?)? validatorFun;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;
  final TextCapitalization textCapitalization;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final double? cursorHeight;
  final Color? cursorColor;
  final bool autoFocus;
  final bool readOnly;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final bool? autoValidate;
  final String counterText;
  final BuildContext context;
  final String? obscuringCharacter;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextStyle? labelStyle;
  final bool? isFloating;
  final MyFont? myFont;
  final Color? colorErrorText;
  bool isHelperVisible;
  String helperText;
  bool isTaskHintShow;
  AutovalidateMode? autoValidateMode;

  BaseTextField(this.context,
      {this.initialValue,
      this.hintText,
      this.controller,
      this.textInputType,
      this.obscureText = false,
      this.fontSize,
      this.autoValidate,
      this.validatorFun,
      this.suffixIcon,
      this.fillColor,
      this.borderColor,
      this.textColor,
      this.hintTextColor,
      this.prefixIcon,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onChange,
      this.textCapitalization = TextCapitalization.none,
      this.borderRadius,
      this.borderWidth = 1,
      this.maxLength,
      this.maxLines = 1,
      this.minLines,
      this.enabled = true,
      this.cursorHeight,
      this.cursorColor,
      this.autoFocus = false,
      this.readOnly = false,
      this.isDense = false,
      this.contentPadding,
      this.textInputAction = TextInputAction.next,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.inputFormatters,
      this.counterText = "",
      this.obscuringCharacter,
      this.fontWeight,
      this.letterSpacing,
      this.hintFontSize,
      this.labelStyle,
      this.isFloating = false,
      this.myFont = MyFont.regular,
      this.colorErrorText,
      this.isHelperVisible = true,
      this.isTaskHintShow = false,
      this.helperText = " ",
      this.autoValidateMode = AutovalidateMode.onUserInteraction})
      : super(
            initialValue: initialValue,
            enabled: enabled,
            controller: controller,
            keyboardType: textInputType,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter ?? '•',
            cursorHeight: cursorHeight,
            cursorColor: cursorColor ?? textColor ?? ColorsUtils.colorBlack,
            autofocus: autoFocus,
            readOnly: readOnly,
            maxLength: maxLength,
            //maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: maxLines,
            minLines: minLines,
            style: BaseTextStyle(
              inheritValue: true,
              fontSize: fontSize ?? dim16,
              // height: 2,
              // fontFeatures: [FontFeature.subscripts()],
              color: textColor ?? ColorsUtils.colorBlack,
              letterSpacing: letterSpacing,
              fontWeight: myFont?.weight,
              fontStyle: myFont?.style,
              fontFamily: myFont?.family,
            ),
            onTap: onTap,
            onChanged: onChange,
            // autovalidate: autoValidate ?? false,
            autovalidateMode: autoValidateMode,
            // cursorHeight: 25,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            textAlign: textAlign,
            //enableInteractiveSelection: false, //Stick cursor at end
            decoration: BaseInputDecoration(context,
                prefixIcon_: prefixIcon,
                fillColor_: fillColor,
                suffixIcon_: suffixIcon,
                isHelperVisible: isHelperVisible,
                helperText_: helperText,
                isDense_: isDense,
                borderRadius: borderRadius,
                borderWidth: borderWidth,
                borderColor: borderColor,
                contentPadding_: contentPadding,
                hintText_: hintText,
                isTaskHintShow: isTaskHintShow,
                hintFontSize: hintFontSize,
                fontWeight: fontWeight,
                hintTextColor: hintTextColor,
                counterText_: counterText,
                colorErrorText: colorErrorText,
                isFloating: isFloating,
                labelStyle_: labelStyle),
            validator: validatorFun,
            autocorrect: false);
}
