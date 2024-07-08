import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(
        //   height: dim30,
        //   width: dim10,
        //   margin: EdgeInsets.only(top: dim1, bottom: dim4),
        //   decoration: const BoxDecoration(
        //     color: ColorsUtils.colorRed1,
        //   ),
        // ),
        BaseText(
          text: title,
          myFont: MyFont.semiBold,
          fontSize: 24,
          color: ColorsUtils.colorBase,
        ),
      ],
    );
  }
}
