import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';

class VerticalDividerWidget extends StatelessWidget {
  final double? thickness;
  final Color? color;
  final double? width;
  final double? topSpace;
  final double? bottomSpace;

  const VerticalDividerWidget({
    Key? key,
    this.thickness,
    this.color,
    this.width,
    this.topSpace,
    this.bottomSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: thickness ?? dim1,
      color: color ?? ColorsUtils.colorGrey1,
      width: width ?? dim2,
      indent: topSpace,
      endIndent: bottomSpace,
    );
  }
}
