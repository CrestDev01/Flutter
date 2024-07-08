// // ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../translations/locale_keys.g.dart';
import 'enum_utils.dart';
import 'functions_utils.dart';

class UrlLaunchUtils {
  //Redirect url
  static Future<void> redirectUrl({
    required String url,
    required BuildContext context,
  }) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        showToastMessage(
          context,
          message: LocaleKeys.url_invalid.tr(),
          status: MessageStatusEnum.error,
        );
      }
    } else {
      showToastMessage(
        context,
        message: LocaleKeys.url_error.tr(),
        status: MessageStatusEnum.error,
      );
    }
  }

  static openGoogleCalendar({
    required BuildContext context,
    required String url,
  }) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
      print("true");
    } else {
      showToastMessage(
        context,
        message: LocaleKeys.url_error.tr(),
        status: MessageStatusEnum.error,
      );
    }
  }
}
