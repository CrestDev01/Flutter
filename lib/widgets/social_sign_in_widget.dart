import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/functions_utils.dart';
import 'image_widget_util.dart';

class SocialSignInWidget extends StatelessWidget {
  final String title;
  final String image;
  final Function onTap;

  const SocialSignInWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        removeFocus(context);
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: dim14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dim12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ColorsUtils.colorLightGrey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(width: getWindowWidth() * (kIsWeb ? 0.3 : 0.2)),
            svgImgAssetWidget(
              image,
              height: dim24,
              width: dim24,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(width: dim14),
            Flexible(
              child: BaseText(
                text: title,
                color: ColorsUtils.colorGrey,
                myFont: MyFont.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
