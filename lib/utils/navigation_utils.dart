import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class NavigationUtils {
  //Navigate to a new screens
  static Future<dynamic> getTo(dynamic widget) async {
    return Get.to(widget);
  }

  //To close snackBars, dialogs, bottomSheets, or anything
  static void getBack({dynamic result}) {
    Get.back(result: result);
  }

  //To go to the next screens and no option to go back to the previous screens
  static void getOff(dynamic widget) {
    Get.off(widget);
  }

  //To go to the next screens and cancel all previous routes
  static Future getOffAll(dynamic widget) async {
    await Get.offAll(widget);
  }

  //Navigate to a new screens in tabs
  static void getToTab(
      {required BuildContext context, required dynamic widget}) {
    pushNewScreen(
      context,
      screen: widget,
      //pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  //Back to previous screens in tabs
  static void getBackTab(BuildContext context) {
    Navigator.pop(context);
  }
}
