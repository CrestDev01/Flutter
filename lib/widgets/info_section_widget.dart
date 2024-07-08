import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

Row buildDetailRowWidget({
  required String title,
  required String value,
  int titleFlex = 2,
  int valueFlex = 4,
  Color? valueColor,
  Color? titlecolor,
  bool showUnderline = false,
  double? titleFontSize,
  double? valueFontSize,
  Function()? onTapValue,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: titleFlex,
        child: BaseText(
          text: title,
          fontSize: titleFontSize ?? dim14,
          color: titlecolor ?? ColorsUtils.colorGrey3,
          myFont: MyFont.regular,
        ),
      ),
      BaseText(
        text: ":  ",
        fontSize: dim14,
        color: titlecolor ?? ColorsUtils.colorGrey3,
        myFont: MyFont.regular,
      ),
      Expanded(
        flex: valueFlex,
        child: InkWell(
          onTap: onTapValue,
          child: BaseText(
            text: value,
            fontSize: valueFontSize ?? dim14,
            color: valueColor ?? ColorsUtils.colorBlack,
            myFont: MyFont.medium,
            textDecoration:
                showUnderline ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    ],
  );
}
