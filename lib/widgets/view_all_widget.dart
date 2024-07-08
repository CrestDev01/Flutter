import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../base_classes/base_text.dart';
import '../translations/locale_keys.g.dart';
import '../utils/dimensions_utils.dart';
import 'image_widget_util.dart';

class ViewAllWidget extends StatelessWidget {
  final Function onTap;

  const ViewAllWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          //View All
          BaseText(
            text: LocaleKeys.view_all.tr(),
            fontSize: dim14,
          ),
          svgImgAssetWidget('ic_next')
        ],
      ),
    );
  }
}
