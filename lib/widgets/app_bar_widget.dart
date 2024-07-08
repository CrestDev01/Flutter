import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/functions_utils.dart';
import '../utils/navigation_utils.dart';
import 'image_widget_util.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool? showBack;
  final bool? isTab;
  final bool isNavigateBack;
  final Function? onBackPressed;
  final String? title;
  final MyFont? myFont;
  List<Widget>? actions = [];

  AppBarWidget({
    Key? key,
    this.showBack = true,
    this.isTab = true,
    this.isNavigateBack = true,
    this.onBackPressed,
    required this.title,
    this.myFont,
    this.actions,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(dim55);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsUtils.colorBase,
      leading: widget.showBack!
          ? InkWell(
              onTap: () {
                _onBackPressed();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: dim18),
                child: svgImgAssetWidget(
                  'ic_arrow_back',
                  color: ColorsUtils.colorWhite,
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: BaseText(
        text: widget.title,
        myFont: MyFont.semiBold,
        color: ColorsUtils.colorWhite,
        fontSize: dim18,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [...?widget.actions],
        ),
        const SizedBox(width: dim10),
      ],
    );
    return Container(
      padding: EdgeInsets.only(
          left: dimMainSpace,
          right: dimMainSpace,
          top: kIsWeb
              ? dim15
              : isPlatformApp()
                  ? (getStatusBarHeight() + (Platform.isAndroid ? dim15 : 0.0))
                  : dim15,
          bottom: dim15),
      decoration: const BoxDecoration(
        color: ColorsUtils.colorBase,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Back arrow
              if (widget.showBack!) ...[
                InkWell(
                  onTap: () {
                    _onBackPressed();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: dim10),
                    child: svgImgAssetWidget(
                      'ic_arrow_back',
                      color: ColorsUtils.colorWhite,
                    ),
                  ),
                ),
              ],
              //App bar title
              BaseText(
                text: widget.title,
                myFont: widget.myFont ?? MyFont.semiBold,
                color: ColorsUtils.colorWhite,
                fontSize: dim18,
              ),
            ],
          ),
          if (widget.actions != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [...?widget.actions],
            )
        ],
      ),
    );
  }
}

extension on _AppBarWidgetState {
  void _onBackPressed() {
    if (widget.onBackPressed != null) {
      widget.onBackPressed!();
    }
    if (widget.isNavigateBack) {
      if (widget.isTab!) {
        NavigationUtils.getBackTab(context);
      } else {
        NavigationUtils.getBack();
      }
    }
  }
}
