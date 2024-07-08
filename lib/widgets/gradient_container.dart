import 'package:flutter/material.dart';
import 'package:boilerplate/utils/functions_utils.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  GradientContainer({
    required this.child,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? getLinearGradient(isVerticalGradient: true),
        borderRadius: borderRadius,
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
