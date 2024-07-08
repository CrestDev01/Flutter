// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScreenTypeWidget extends StatelessWidget {
  final Widget mobileView;
  Widget? tabletView;
  Widget? desktopView;

  ScreenTypeWidget(
      {Key? key, required this.mobileView, this.tabletView, this.desktopView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => mobileView,
      tablet: (BuildContext context) => tabletView ?? mobileView,
      desktop: (BuildContext context) => desktopView ?? mobileView,
    );
  }
}
