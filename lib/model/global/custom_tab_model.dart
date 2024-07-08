import 'package:flutter/material.dart';

class CustomTabModel {
  String? tabName;
  bool showCount;
  int count;
  Color? backColor;

  CustomTabModel({
    required this.tabName,
    this.showCount = false,
    this.count = 0,
    this.backColor,
  });
}
