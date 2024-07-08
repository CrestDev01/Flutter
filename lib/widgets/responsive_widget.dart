import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import '../utils/constant_utils.dart';
import '../utils/functions_utils.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;
  final bool? isWaiting;
  final bool? isResponsive;
  final Color? backgroundColor;
  final double? responsiveFactor;

  const ResponsiveWidget(
      {Key? key,
      required this.child,
      this.isWaiting = false,
      this.isResponsive = true,
      this.backgroundColor = ColorsUtils.colorWhite,
      this.responsiveFactor = ConstantUtils.responsiveFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = getWindowHeight();

    return OrientationBuilder(
      builder: (context, orientation) {
        return Center(
          child: Container(
            width: getWindowWidth(isFactored: false),
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Center(
              child: SizedBox(
                  width: getWindowWidth(), height: height, child: child),
            ),
          ),
        );
      },
    );
  }
}
