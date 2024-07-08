import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/navigation_utils.dart';
import 'image_widget_util.dart';

class AnimatedAppbarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  int? toggle = 0;
  final bool? showBack;
  String title;
  double? fontSize;
  Function() onPressed;
  Function(String) onSearchResult;
  final Function? onBackPressed;
  final bool isNavigateBack;
  TextEditingController topSearchController = TextEditingController();
  FocusNode topSearchFocusNode = FocusNode();
  List<Widget>? actions = [];

  AnimatedAppbarWidget({
    Key? key,
    required this.title,
    this.showBack = true,
    this.toggle = 0,
    required this.onPressed,
    this.isNavigateBack = true,
    this.onBackPressed,
    this.fontSize,
    this.actions,
    required this.topSearchController,
    required this.topSearchFocusNode,
    required this.onSearchResult,
  }) : super(key: key);

  @override
  State<AnimatedAppbarWidget> createState() => _AnimatedAppbarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(dim55);
}

class _AnimatedAppbarWidgetState extends State<AnimatedAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsUtils.colorBase,
      leading: widget.showBack!
          ? Padding(
              padding: const EdgeInsets.all(dim15),
              child: InkWell(
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
            )
          : SizedBox(),
      title: AnimatedOpacity(
        opacity: (widget.toggle == 0) ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: BaseText(
          text: widget.title,
          myFont: MyFont.semiBold,
          color: ColorsUtils.colorWhite,
          fontSize: widget.fontSize ?? dim20,
        ),
      ),
      actions: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: (widget.toggle == 0)
              ? 48.0
              : MediaQuery.of(context).size.width / 1,
          curve: Curves.easeOut,
          child: Stack(
            children: [
              _animatedSearchWidget(),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: IconButton(
                  splashRadius: 19.0,
                  icon: AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: widget.toggle == 0
                        ? const Icon(
                            Icons.search,
                            size: dim28,
                            color: ColorsUtils.colorWhite,
                          )
                        : const Icon(
                            Icons.clear,
                            size: 26,
                            color: ColorsUtils.colorWhite,
                          ),
                  ),
                  onPressed: widget.onPressed,
                ),
              ),
            ],
          ),
        ),
        if (widget.actions != null) ...widget.actions!
      ],
    );
  }

  AnimatedPositioned _animatedSearchWidget() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: 50,
      right: 60,
      curve: Curves.easeOut,
      bottom: 8.0,
      top: 6,
      child: AnimatedOpacity(
        opacity: (widget.toggle == 0) ? 0.0 : 1.0,
        duration: Duration(milliseconds: 200),
        child: TextField(
          controller: widget.topSearchController,
          focusNode: widget.topSearchFocusNode,
          cursorRadius: Radius.circular(10.0),
          cursorWidth: 2.0,
          cursorColor: ColorsUtils.colorWhite,
          style: const TextStyle(
            color: ColorsUtils.colorWhite,
            fontSize: dim17,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: 'Search...',
            hintText: "Search...",

            contentPadding: const EdgeInsets.only(top: 8),
            labelStyle: const TextStyle(
              color: ColorsUtils.colorWhite,
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),

            hintStyle: TextStyle(
              color: ColorsUtils.colorWhite.withOpacity(0.5),
              fontSize: 17.0,
            ),
            // alignLabelWithHint: true,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (val) {
            if (val.isNotEmpty) {
              widget.onSearchResult(val);
              //viewModel.searchRecordByEidOrVisualTag(val);
            }
          },
        ),
      ),
    );
  }
}

extension on _AnimatedAppbarWidgetState {
  void _onBackPressed() {
    if (widget.onBackPressed != null) {
      widget.onBackPressed!();
    }
    if (widget.isNavigateBack) {
      NavigationUtils.getBack();
    }
  }
}
