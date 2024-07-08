// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../model/global/custom_tab_model.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/functions_utils.dart';
import 'divider_widget.dart';

class CustomTabWidget extends StatefulWidget {
  List<CustomTabModel> tabs = [];
  List<Widget> tabViews = [];
  Function(int, CustomTabModel)? onTabChange;
  int selectedIndex;
  bool showTabs;
  bool showTabView;
  bool isScrollable;

  CustomTabWidget({
    Key? key,
    required this.tabs,
    required this.tabViews,
    this.onTabChange,
    this.selectedIndex = 0,
    this.showTabs = true,
    this.showTabView = true,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;

    tabController = TabController(
      initialIndex: selectedIndex,
      length: widget.tabs.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTabs) ...[
          //Tabs
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
              controller: tabController,
              padding: EdgeInsets.zero,
              tabAlignment:
                  widget.isScrollable ? TabAlignment.start : TabAlignment.fill,
              tabs: List.generate(
                widget.tabs.length,
                (index) => _tabView(tab: widget.tabs[index], index: index),
              ),
              isScrollable: widget.isScrollable,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorsUtils.colorBase,
                    width: 3,
                  ),
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              physics: const AlwaysScrollableScrollPhysics(),
              dividerColor: ColorsUtils.colorTransparent,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  if (widget.onTabChange != null) {
                    widget.onTabChange!(selectedIndex, widget.tabs[index]);
                  }
                });
              },
            ),
          ),
          const SizedBox(height: dim8),
          // const DividerWidget(color: ColorsUtils.colorGrey2),
          // const SizedBox(height: dim15),
        ],
        if (widget.showTabView)
          //TabViews
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.tabViews,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

extension on _CustomTabWidgetState {
  //Tab view
  Widget _tabView({required CustomTabModel tab, required int index}) {
    bool isSelected = index == selectedIndex;

    return Container(
      width: widget.isScrollable ? null : double.infinity,
      padding: const EdgeInsets.symmetric(vertical: dim6, horizontal: dim15),
      child: BaseText(
        text: tab.tabName,
        color: isSelected ? ColorsUtils.colorBase : ColorsUtils.colorBlack,
        textAlign: TextAlign.center,
        myFont: isSelected ? MyFont.semiBold : MyFont.regular,
      ),
    );
  }
}
