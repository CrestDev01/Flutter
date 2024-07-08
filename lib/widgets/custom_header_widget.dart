import 'package:flutter/material.dart';

import '../utils/dimensions_utils.dart';
import 'image_widget_util.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader(
      {super.key,
      this.onSearchPress,
      this.leading,
      this.trailing,
      this.centerWidget});
  final void Function()? onSearchPress;
  final Widget? leading;
  final Widget? centerWidget;
  final List<Widget>? trailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: dim16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading ?? const SizedBox(),
                const Spacer(),
                // InkWell(
                //   onTap: onSearchPress,
                //   child: svgImgAssetWidget('ic_search',
                //       color: ColorsUtils.colorRed1, height: dim24),
                // ),

                ...trailing ?? [],
              ],
            ),
            // imgAssetWidget('ic_title_image.png', height: dim36),
            centerWidget ?? imgAssetWidget('ic_title_image.png', height: dim36),
          ],
        ));
  }
}
