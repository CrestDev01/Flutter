import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'enum_utils.dart';
import 'functions_utils.dart';

class HelperUtils {
  static makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      //throw 'Could not launch $launchUri';
      showToastMessage(context,
          message: 'Could not launch $launchUri',
          status: MessageStatusEnum.error);
    }
  }

  static sendEmails(String email, BuildContext context) async {
    var url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showToastMessage(context,
          message: 'Could not launch $url', status: MessageStatusEnum.error);
    }
  }

  static MaskedInputFormatter getMobileNumberFormatter() {
    return MaskedInputFormatter('(###) ###-####');
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // Unique ID on Android
    }
  }

  // static  Color getColorFromEvent(calendar.Event event) {
  //   if (event.colorId != null && event.colorId != "0") {
  //     return _parseColor(event.colorId!);
  //   } else {
  //     return Colors.grey; // Default color
  //   }
  // }
}
