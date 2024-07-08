import 'package:flutter/material.dart';
import 'package:boilerplate/widgets/view_all_widget.dart';

import '../base_classes/base_text.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

class HeaderWidget extends StatelessWidget {
  final bool isVisible;
  final String headerText;
  final bool isVisibleViewAll;
  final Function? onViewAllTap;

  const HeaderWidget({
    Key? key,
    required this.isVisible,
    required this.headerText,
    this.isVisibleViewAll = true,
    this.onViewAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Row(
        children: [
          Expanded(
            child: BaseText(
              text: headerText,
              fontSize: dim20,
              myFont: MyFont.semiBold,
            ),
          ),
          Visibility(
            visible: isVisibleViewAll,
            child: ViewAllWidget(
              onTap: () {
                if (onViewAllTap != null) {
                  onViewAllTap!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
