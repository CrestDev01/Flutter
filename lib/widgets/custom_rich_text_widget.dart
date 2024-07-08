import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/functions_utils.dart';

class CustomRichTextWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Function? onTapText2;
  final Color? color;
  double? fontSize1;
  double? fontSize2;

  CustomRichTextWidget({
    Key? key,
    required this.text1,
    required this.text2,
    this.onTapText2,
    this.color,
    this.fontSize1,
    this.fontSize2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
          text: text1,
          fontSize: fontSize1 ?? dim14,
        ),
        const SizedBox(width: dim6),
        InkWell(
          onTap: (onTapText2 != null)
              ? () {
                  removeFocus(context);
                  onTapText2!();
                }
              : null,
          child: BaseText(
            text: text2,
            myFont: MyFont.semiBold,
            fontSize: fontSize2 ?? dim14,
            // textDecoration: TextDecoration.underline,
            color: color ?? ColorsUtils.colorBlack,
          ),
        ),
      ],
    );
  }
}
