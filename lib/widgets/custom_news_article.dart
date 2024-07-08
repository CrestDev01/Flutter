import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import 'image_widget_util.dart';

class CustomNewsArticle extends StatelessWidget {
  const CustomNewsArticle(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.onTap});
  final String imageUrl;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          networkImgWidget(
            imageUrl,
            height: dim60,
            width: dim60,
            boxFit: BoxFit.cover,
          ),
          const SizedBox(width: dim12),
          Expanded(
            child: BaseText(
              text: title,
              fontSize: dim13,
              myFont: MyFont.semiBold,
            ),
          )
        ],
      ),
    );
  }
}
