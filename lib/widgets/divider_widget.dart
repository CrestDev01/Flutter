import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';

class DividerWidget extends StatelessWidget {
  final double? thickness;
  final Color? color;
  final double? height;

  const DividerWidget({Key? key, this.thickness, this.color, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness ?? dim1,
      color: color ?? ColorsUtils.colorGrey1,
      height: height,
    );
  }
}
