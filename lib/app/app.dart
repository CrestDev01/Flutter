// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:boilerplate/utils/validation_utils.dart';
import '../model/global/app_config_model.dart';
import '../screens/auth/splash/splash_screen.dart';
import '../utils/colors_utils.dart';
import '../utils/constant_utils.dart';
import '../utils/enum_utils.dart';
import '../utils/functions_utils.dart';
import '../utils/locale_utils.dart';
import '../utils/preference_utils.dart';
import '../webservices/api_urls.dart';
import '../widgets/app_scroll_behavior.dart';

Future<Widget> initializeApp({
  required AppConfig appConfig,
}) async {
  ReceivePort port = ReceivePort();

  WidgetsFlutterBinding.ensureInitialized();

  debugLogText("Environment := ${appConfig.flavor} := ${appConfig.appName}");

  if (appConfig.flavor == FlavorEnum.dev.value) {
    ConstantUtils.isDevEnv = true;
    APIUrls.baseURL = APIUrls.devURL;
  }

  await PreferenceUtils.initSharedPrefs();
  debugLogText('Init pref........');
  await _initEasyLocalization();

  // Set Device Orientation
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  return await runMain(appConfig: appConfig);
}

class RootApp extends StatefulWidget {
  final AppConfig? appConfig;
  final Widget widget;

  const RootApp({super.key, required this.appConfig, required this.widget});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: widget.appConfig!.appName.returnString(),
      navigatorKey: ConstantUtils.globalKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      fallbackLocale: LocaleUtils.localeEn,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsUtils.colorWhite1,
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ColorsUtils.colorBase,
            selectionColor: ColorsUtils.colorLightBase,
            selectionHandleColor: ColorsUtils.colorLightBase),
      ),
      scrollBehavior: AppScrollBehavior(),
      home: Scaffold(
        body: widget.widget,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Future<Widget> runMain({required AppConfig appConfig}) async {
  return EasyLocalization(
    supportedLocales: LocaleUtils.all,
    path: ConstantUtils.localesPath,
    fallbackLocale: LocaleUtils.localeEn,
    startLocale: LocaleUtils.localeEn,
    child: RootApp(
      appConfig: appConfig,
      widget: const SplashScreen(),
    ),
  );
}

//Easy localization initialization
Future _initEasyLocalization() async {
  //Disable easy localization logs
  EasyLocalization.logger.enableBuildModes = [];

  await EasyLocalization.ensureInitialized();
}

Locale getInitialLocale() {
  Locale locale;
  if (!isNullEmptyOrFalse(
      PreferenceUtils.shared.getString(key: PreferenceKeys.selectedLanguage))) {
    locale = Locale(PreferenceUtils.shared
        .getString(key: PreferenceKeys.selectedLanguage)!);
  } else {
    if (!isNullEmptyOrFalse(LocaleUtils.deviceLocale) &&
        !isNullEmptyOrFalse(LocaleUtils.deviceLocale!.languageCode) &&
        LocaleUtils.deviceLocale!.languageCode == "pl") {
      locale = LocaleUtils.localePo;
    } else {
      locale = LocaleUtils.localeEn;
    }
  }

  return locale;
}
