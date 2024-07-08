import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import 'image_widget_util.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String image;
  final String text;
  double? imageHeight;
  NoDataFoundWidget({
    Key? key,
    required this.image,
    required this.text,
    this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: imgAssetWidget(
            height: imageHeight ?? dim70,
            image,
          ),
        ),
        const SizedBox(
          height: dim20,
        ),
        BaseText(text: text, myFont: MyFont.bold, fontSize: dim18),
      ],
    );
  }
}
