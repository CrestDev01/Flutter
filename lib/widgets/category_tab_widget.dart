import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

class CategoryTabItem extends StatelessWidget {
  const CategoryTabItem({
    super.key,
    required this.onTap,
    required this.text,
    required this.isSelected,
  });
  final void Function() onTap;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: dim12, vertical: dim6),
        margin: const EdgeInsets.symmetric(vertical: dim4, horizontal: dim8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dim30),
          color:
              isSelected ? ColorsUtils.colorDarkBlue : ColorsUtils.colorWhite,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 0.0),
              blurRadius: 8,
              spreadRadius: 0,
              color: ColorsUtils.colorBlack.withOpacity(0.25),
            ),
          ],
        ),
        child: BaseText(
          text: text,
          color: isSelected ? ColorsUtils.colorWhite : ColorsUtils.colorBlue,
          fontSize: 12,
          myFont: MyFont.medium,
        ),
      ),
    );
  }
}
