import 'dart:convert';

import 'package:flutter/services.dart';

import 'constant_utils.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en": TranslationFiles.en,
    "de": TranslationFiles.de,
    "pl": TranslationFiles.pl,
    "nl": TranslationFiles.nl
  };
}

class TranslationFiles {
  static Map<String, String> en = {};
  static Map<String, String> de = {};
  static Map<String, String> pl = {};
  static Map<String, String> nl = {};
  static Future<void> loadLanguageFiles() async {
    Map<String, dynamic> enData = jsonDecode(
        await rootBundle.loadString(ConstantUtils.localesPath + "/en.json"));

    en = enData.map((key, value) => MapEntry(key, value.toString()));
    Map<String, dynamic> zhData = jsonDecode(
        await rootBundle.loadString(ConstantUtils.localesPath + "/de.json"));
    de = zhData.map((key, value) => MapEntry(key, value.toString()));

    Map<String, dynamic> plData = jsonDecode(
        await rootBundle.loadString(ConstantUtils.localesPath + "/pl.json"));
    pl = plData.map((key, value) => MapEntry(key, value.toString()));
    Map<String, dynamic> nlData = jsonDecode(
        await rootBundle.loadString(ConstantUtils.localesPath + "/nl.json"));
    nl = nlData.map((key, value) => MapEntry(key, value.toString()));
  }
}
