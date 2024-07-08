import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleUtils {
  static Locale? deviceLocale;
  static const Locale localeEn = Locale('en');
  static const Locale localeGr = Locale('de');
  static const Locale localePo = Locale('pl');
  static const Locale localeNl = Locale('nl');

  static final all = [localeEn, localeGr, localePo, localeNl];

  //Update locale
  static updateLocale(BuildContext context, Locale locale) {
    Get.updateLocale(locale);
    context.setLocale(locale);
  }
}
