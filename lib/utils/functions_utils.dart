// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:boilerplate/utils/preference_utils.dart';
import 'package:boilerplate/utils/validation_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:tuple/tuple.dart';

import '../base_classes/base_text.dart';
import '../model/auth/user_model.dart';
import '../translations/locale_keys.g.dart';
import 'colors_utils.dart';
import 'constant_utils.dart';
import 'dimensions_utils.dart';
import 'enum_utils.dart';
import 'fonts_utils.dart';

BuildContext globalContext =
    ConstantUtils.globalKey.currentContext!; //Global context across app

//Get device window size
Size getWindowSize() {
  return MediaQuery.of(globalContext).size;
}

//Get device window width
double getWindowWidth({bool isFactored = true}) {
  //debugLogText('Window Width => ${getWindowSize().width}');
  return isPlatformApp()
      ? kIsWeb
          ? isFactored
              ? (getWindowSize().width * ConstantUtils.responsiveFactor)
              : getWindowSize().width
          : getWindowSize().width
      : ConstantUtils.desktopWindowWidth;
}

//Get device window height
double getWindowHeight() {
  //debugLogText('Window Height => ${getWindowSize().height}');
  return isPlatformApp()
      ? getWindowSize().height
      : ConstantUtils.desktopWindowHeight;
}

//Get device window orientation
Orientation getWindowOrientation() {
  return MediaQuery.of(globalContext).orientation;
}

//Debug print text
void debugPrintText(String text) {
  debugPrint(text);
}

//Debug log text
void debugLogText(
  String text, {
  String? name,
  Object? error,
}) {
  if (kDebugMode) {
    developer.log(
      text,
      name: name ?? "Log",
      error: error,
    );
  }
}

//Show snackBar
void showToastMessage(BuildContext context,
    {String? title,
    required String message,
    Widget? icon,
    MessageStatusEnum status = MessageStatusEnum.success,
    bool showSnackBar = true,
    int displayDuration = 3,
    double customPadding = .87}) {
  if (showSnackBar) {
    showTopSnackBar(
        Overlay.of(context),
        Container(
          width: getWindowWidth(),
          padding: const EdgeInsets.all(dim10),
          decoration: const BoxDecoration(
              color: ColorsUtils.colorWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(dim6),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*icon ??
                  (status == MessageStatus.success
                      ? svgImgAssetWidget('ic_success')
                      : svgImgAssetWidget('ic_error')),
              const SizedBox(width: dim10),*/
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: title ??
                          (status == MessageStatusEnum.success
                              ? LocaleKeys.success.tr()
                              : "Failed"),
                      myFont: MyFont.semiBold,
                      color: status.color,
                    ),
                    const SizedBox(height: dim4),
                    Flexible(
                      child: BaseText(
                        text: message,
                        fontSize: dim15,
                        color: ColorsUtils.colorBase,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        displayDuration: Duration(seconds: displayDuration),
        reverseAnimationDuration: const Duration(seconds: 0),
        animationDuration: const Duration(milliseconds: 500),
        curve: Curves.decelerate);
  }
}

//Remove textField focus
void removeFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

//Check internet connectivity status
Future<bool> checkConnectivity(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  bool connected = false;

  switch (connectivityResult[0]) {
    case ConnectivityResult.bluetooth:
    case ConnectivityResult.wifi:
    case ConnectivityResult.ethernet:
    case ConnectivityResult.mobile:
    case ConnectivityResult.vpn:
    case ConnectivityResult.other:
      connected = true;
      break;
    case ConnectivityResult.none:
      connected = false;
      break;
  }

  if (!connected) {
    showToastMessage(context,
        message: LocaleKeys.internet_error.tr(),
        title: LocaleKeys.no_internet.tr(),
        status: MessageStatusEnum.error,
        icon: const Icon(Icons.signal_wifi_connected_no_internet_4,
            color: ColorsUtils.colorRed, size: dim30));
  }

  return connected;
}

//Determine whether the keyboard is hidden.
Future<bool> get keyboardHidden async {
  // If the embedded value at the bottom of the window is not greater than 0, the keyboard is not displayed.
  check() => (WidgetsBinding.instance.window.viewInsets.bottom ?? 0) <= 0;
  // If the keyboard is displayed, return the result directly.
  if (!check()) return false;
  // If the keyboard is hidden, in order to cope with the misjudgment caused by the keyboard display/hidden animation process, wait for 0.1 seconds and then check again and return the result.
  return await Future.delayed(const Duration(milliseconds: 100), () => check());
}

//Get status bar height
double getStatusBarHeight() {
  // debugLogText('StatusBar Height => ${MediaQuery.of(globalContext).viewPadding.top}');
  return MediaQuery.of(globalContext).viewPadding.top;
}

//Check platform is app or desktop
bool isPlatformApp() {
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    } else if (Platform.isWindows ||
        Platform.isMacOS ||
        Platform.isLinux ||
        Platform.isFuchsia) {
      return false;
    }
  }

  return true;
}

//Get bearer token
String getBearerToken() {
  return PreferenceUtils.shared.getString(key: PreferenceKeys.authToken) ?? "";
}

// Save user data
void saveUserData({required User userModel}) {
  PreferenceUtils.shared.setString(
    key: PreferenceKeys.userData,
    value: jsonEncode(userModel.toJson()),
  );
}

// save user full Name

void saveUserFullName({required String fullName}) {
  PreferenceUtils.shared.setString(
    key: PreferenceKeys.userFullName,
    value: fullName,
  );
}

//Save user Image
void saveUserImage({required String imageUrl}) {
  PreferenceUtils.shared.setString(
    key: PreferenceKeys.userImage,
    value: imageUrl,
  );
}

void saveUserRole({required int userRole}) {
  PreferenceUtils.shared.setInt(
    key: PreferenceKeys.userRole,
    value: userRole,
  );
}

bool isClientUser() {
  return PreferenceUtils.shared.getInt(key: PreferenceKeys.userRole) == 4;
}

// Get user data
User getUserData() {
  return User.fromJson(
    jsonDecode(PreferenceUtils.shared.getString(key: PreferenceKeys.userData)!),
  );
}

//Get user full name
String getUserFullName() {
  return PreferenceUtils.shared.getString(key: PreferenceKeys.userFullName) ??
      "";
}

//Get user image
String getUserImage() {
  return PreferenceUtils.shared.getString(key: PreferenceKeys.userImage) ?? "";
}

//Get linear gradient
Gradient getLinearGradient({bool isVerticalGradient = false}) {
  return isVerticalGradient
      ? const LinearGradient(
          colors: [
            ColorsUtils.colorLightBase,
            ColorsUtils.colorBase,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : LinearGradient(
          colors: [
            ColorsUtils.colorLightBase,
            ColorsUtils.colorBase,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
}

//Save credentials
void saveCredentials(
    {required bool isRemember, String email = '', String password = ''}) {
  PreferenceUtils.shared.setString(
    key: PreferenceKeys.credentials,
    value: jsonEncode({
      PreferenceKeys.isRemember: isRemember,
      PreferenceKeys.email: email,
      PreferenceKeys.password: password,
    }),
  );
}

//Get credentials
Tuple3<bool, String, String> getCredentials() {
  Map<String, dynamic>? credentials = PreferenceUtils.shared
          .getString(key: PreferenceKeys.credentials)
          .isNullEmptyString()
      ? null
      : jsonDecode(
          PreferenceUtils.shared.getString(key: PreferenceKeys.credentials)!);

  if (credentials != null) {
    return Tuple3(
      credentials[PreferenceKeys.isRemember] ?? false,
      credentials[PreferenceKeys.email] ?? '',
      credentials[PreferenceKeys.password] ?? '',
    );
  }
  return const Tuple3(false, '', '');
}

//Digit formatter
TextInputFormatter digitFormatter() {
  return FilteringTextInputFormatter.digitsOnly;
}

//Decimal Digit formatter
TextInputFormatter decimalDigitFormatter() {
  return FilteringTextInputFormatter.allow((RegExp("[.0-9]")));
}

bool keyboardKeyEvent(KeyEvent event) {
  final key = event.physicalKey.debugName;
  debugLogText("Key: $key");

  if (event is KeyDownEvent) {
    debugLogText("Key down: $key");
  } else if (event is KeyUpEvent) {
    debugLogText("Key up: $key");
  } else if (event is KeyRepeatEvent) {
    debugLogText("Key repeat: $key");
  }

  return true;
}

//Get package info
// Future<PackageInfo> getPackageInfo() async {
//   return await PackageInfo.fromPlatform();
// }

EdgeInsets topPaddingForDevice({required BuildContext context}) {
  return EdgeInsets.only(
      top: Platform.isIOS ? dimMainSpaceBottom * 1.8 : dimMainSpaceBottom);
}

String getStorageSizeString({required int bytes, int decimals = 1}) {
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var index = 0;
  var size = bytes.toDouble();
  while (size >= 1024) {
    size /= 1024;
    index++;
  }
  return '${size.toInt()}${suffixes[index]}';
}

bool isEmergencyVisit(String type) {
  return !type.toLowerCase().contains('standard');
}

// showImageInPreviewMode(
//     {required BuildContext context, required String imageUrl}) {
//   MultiImageProvider multiImageProvider = MultiImageProvider([
//     NetworkImage(imageUrl),
//   ]);
//   showImageViewerPager(
//     context,
//     multiImageProvider,
//     immersive: true,
//     onPageChanged: (page) {
//       debugPrint("page changed to $page");
//     },
//     onViewerDismissed: (page) {
//       debugPrint("dismissed while on page $page");
//     },
//     useSafeArea: false,
//     doubleTapZoomable: true,
//     swipeDismissible: true,
//   );
// }

String timeOfDayToFloat(TimeOfDay time) {
  return (time.hour + (time.minute / 60.0)).toStringAsFixed(2);
}

TimeOfDay durationToTimeOfDay(int durationInSeconds) {
  int hours = (durationInSeconds / 3600).floor();
  int minutes = ((durationInSeconds % 3600) / 60).floor();
  return TimeOfDay(hour: hours, minute: minutes);
}
