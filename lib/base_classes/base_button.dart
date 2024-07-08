import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/functions_utils.dart';
import 'base_text.dart';

class BaseMaterialButton extends MaterialButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final bool isFullWidth;
  final MyFont myFont;
  final Widget? trailing;
  final Widget? leading;
  final Widget? childWidget;

  BaseMaterialButton(
    this.buttonText,
    this.onPressed, {
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontStyle,
    this.fontWeight,
    this.leading,
    this.trailing,
    this.childWidget,
    this.isFullWidth = true,
    this.myFont = MyFont.semiBold,
  }) : super(
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? dim100),
                border: Border.all(
                  color: borderColor ?? ColorsUtils.colorTransparent,
                ),
              ),
              width: isFullWidth ? double.infinity : null,
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding ?? dim14,
                  horizontal: horizontalPadding ?? dim14),
              child: childWidget ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null)
                        Padding(
                          padding: const EdgeInsets.only(right: dim5),
                          child: leading,
                        ),
                      BaseText(
                        text: buttonText,
                        color: textColor ?? ColorsUtils.colorWhite,
                        fontSize: fontSize ?? dim16,
                        fontStyle: fontStyle,
                        fontWeight: fontWeight,
                        myFont: myFont,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
            ),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? dim100),
          ),
          color: buttonColor ?? ColorsUtils.colorBase,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        );
}

class BaseGradientButton extends MaterialButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final bool isFullWidth;
  final MyFont myFont;
  final Gradient? gradient;

  BaseGradientButton(this.buttonText, this.onPressed,
      {super.key,
      this.buttonColor,
      this.textColor,
      this.fontSize,
      this.borderRadius,
      this.horizontalPadding,
      this.verticalPadding,
      this.fontStyle,
      this.fontWeight,
      this.isFullWidth = true,
      this.gradient,
      this.myFont = MyFont.semiBold})
      : super(
          child: ClipRRect(
            child: Container(
              width: isFullWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  gradient:
                      gradient ?? getLinearGradient(isVerticalGradient: true),
                  borderRadius: BorderRadius.circular(borderRadius ?? dim100)),
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding ?? dim14,
                  horizontal: horizontalPadding ?? dim14),
              child: BaseText(
                text: buttonText,
                color: textColor ?? ColorsUtils.colorWhite,
                fontSize: fontSize ?? dim16,
                fontStyle: fontStyle,
                fontWeight: fontWeight,
                myFont: myFont,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? dim100),
          ),
          color: buttonColor ?? ColorsUtils.colorWhite,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        );
}

class BaseOutlinedButton extends OutlinedButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final double? borderWidth;
  final bool showIcon;
  final bool isFullWidth;
  final MyFont myFont;
  final Widget? trailing;
  final Widget? leading;

  BaseOutlinedButton(this.buttonText, this.onPressed,
      {super.key,
      this.buttonColor,
      this.textColor,
      this.fontSize,
      this.borderColor,
      this.borderRadius,
      this.horizontalPadding,
      this.verticalPadding,
      this.fontStyle,
      this.fontWeight,
      this.borderWidth,
      this.showIcon = false,
      this.isFullWidth = true,
      this.trailing,
      this.leading,
      this.myFont = MyFont.regular})
      : super(
          child: ButtonView().buttonView(
              buttonText: buttonText,
              textColor: textColor,
              fontSize: fontSize,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              showIcon: showIcon,
              isFullWidth: isFullWidth,
              trailing: trailing,
              leading: leading,
              myFont: myFont),
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor ?? ColorsUtils.colorBase,
              foregroundColor: buttonColor ?? ColorsUtils.colorBase,
              side: BorderSide(
                  color: borderColor ?? ColorsUtils.colorBlack,
                  width: borderWidth ?? 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? dim8),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding ?? dim8,
                  horizontal: horizontalPadding ?? dim12)),
        );
}

class ButtonView {
  Widget buttonView(
      {required String? buttonText,
      Color? textColor,
      double? fontSize,
      FontStyle? fontStyle,
      FontWeight? fontWeight,
      bool? showIcon,
      bool? isFullWidth,
      Widget? trailing,
      Widget? leading,
      MyFont? myFont}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showIcon! && leading != null) leading,
        //Text
        Flexible(
          child: SizedBox(
            // width: isFullWidth! ? double.infinity : null,
            child: BaseText(
              text: buttonText!,
              color: textColor ?? ColorsUtils.colorWhite,
              fontSize: fontSize ?? dim14,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              myFont: myFont!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (showIcon && trailing != null) const SizedBox(width: dim8),
        if (showIcon && trailing != null) trailing,
      ],
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double elevation;

  RoundedIconButton({
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    this.size = 50.0,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: CircleBorder(),
      elevation: elevation,
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: size * 0.5, // Adjust icon size relative to button size
          ),
        ),
      ),
    );
  }
}
