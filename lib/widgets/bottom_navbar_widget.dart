// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../base_classes/base_text_style.dart';
import '../model/global/bottom_bar_items_model.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import 'image_widget_util.dart';

class BottomNavbarWidget extends StatefulWidget {
  List<BottomBarItemsModel> bottomBarItems = [];
  List<Widget> pageViewsList = [];
  Function(int)? onTabChange;
  int initialIndex;
  bool changeTab;

  BottomNavbarWidget({
    Key? key,
    required this.bottomBarItems,
    required this.pageViewsList,
    this.onTabChange,
    this.initialIndex = 0,
    this.changeTab = false,
  }) : super(key: key);

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  PersistentTabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = PersistentTabController(initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.changeTab) {
      tabController?.jumpToTab(widget.initialIndex);

      setState(() {});
    }

    return _bottomNavigationBar(context);
  }
}

extension on _BottomNavbarWidgetState {
  //Bottom navigation bar view
  Widget _bottomNavigationBar(BuildContext context) {
    return PersistentTabView(
      context,
      controller: tabController,
      screens: widget.pageViewsList,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorsUtils.colorBase,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style14,
      // navBarStyle: NavBarStyle.style14,
      navBarHeight: dim70,
      onItemSelected: (index) {
        if (index != 3) {
          widget.initialIndex = index;
        }

        if (widget.onTabChange != null) {
          widget.onTabChange!(index);
        }
        setState(() {});
      },
    );
  }

  //Navbar items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return List<PersistentBottomNavBarItem>.generate(
        widget.bottomBarItems.length, (index) {
      return _navBarItemView(
          model: widget.bottomBarItems[index],
          index: index,
          isSelected: widget.initialIndex == index);
    });
  }

  //Navbar item view
  PersistentBottomNavBarItem _navBarItemView(
      {required BottomBarItemsModel model,
      required int index,
      required bool isSelected}) {
    return PersistentBottomNavBarItem(
      icon: imgAssetWidget(
        model.icon!,
        width: dim24,
        height: dim24,
        color: isSelected ? ColorsUtils.colorWhite : ColorsUtils.colorWhite,
      ),
      title: model.itemName,
      activeColorPrimary: ColorsUtils.colorWhite,
      activeColorSecondary: ColorsUtils.colorWhite,
      inactiveColorPrimary: ColorsUtils.colorWhite,
      inactiveColorSecondary: ColorsUtils.colorWhite,
      textStyle: BaseTextStyle(
        myFont: MyFont.regular,
        fontFamily: MyFont.regular.family,
      ),
    );
  }
}
