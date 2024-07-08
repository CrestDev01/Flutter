import 'package:flutter/material.dart';

import '../utils/functions_utils.dart';
import 'responsive_widget.dart';

class BackgroundColorWidget extends StatelessWidget {
  final Widget child;

  const BackgroundColorWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      child: Container(
        alignment: Alignment.center,
        height: getWindowHeight(),
        width: getWindowWidth(),
        decoration: BoxDecoration(
          gradient: getLinearGradient(),
        ),
        child: child,
      ),
    );
  }
}
