import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../translations/locale_keys.g.dart';
import 'custom_dialog_utils.dart';
import 'functions_utils.dart';

class PermissionsUtils {
  static PermissionsUtils? _instance;

  PermissionsUtils._internal() {
    _instance = this;
  }

  factory PermissionsUtils() => _instance ?? PermissionsUtils._internal();

  static PermissionsUtils get shared => PermissionsUtils();
}

extension PermissionExt on PermissionsUtils {
  //Check and request storage permission
  checkAndRequestStoragePermission(void Function(bool status) completion,
      String title, String description) async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isPermanentlyDenied) {
      askUserToGivePermissionFromSetting(
          title: title, description: description);
    }
    completion(permissionStatus.isGranted);
  }

  //Check and request single permission
  checkAndRequestPermission(
      {required Permission permission,
      required void Function(bool status) completion,
      required String title,
      required String description}) async {
    //If web/macOS
    if (kIsWeb || Platform.isMacOS) {
      completion(true);
    }
    //If Android/iOS
    else {
      PermissionStatus permissionStatus = await permission.request();
      if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
        askUserToGivePermissionFromSetting(
            title: title, description: description);
      }
      if (Platform.isIOS) {
        completion(permissionStatus.isGranted || permissionStatus.isLimited);
      } else {
        completion(permissionStatus.isGranted);
      }
    }
  }

  //Check and request multiple permissions
  checkAndRequestMultiplePermissions(
      {required List<Permission> permissions,
      required void Function(bool status) completion,
      required String title,
      required String description}) async {
    //If web/macOS
    if (kIsWeb || Platform.isMacOS) {
      completion(true);
    }
    //If Android/iOS
    else {
      if (permissions.isNotEmpty) {
        Map<Permission, PermissionStatus> statuses =
            await permissions.request();
        debugLogText("Permissions => $statuses");

        if (statuses.containsValue(PermissionStatus.permanentlyDenied)) {
          askUserToGivePermissionFromSetting(
              title: title, description: description);
        }

        completion(statuses.entries
                .where((element) => element.value == PermissionStatus.granted)
                .length ==
            permissions.length);
      }
    }
  }

  //Ask User to give permission from setting
  askUserToGivePermissionFromSetting(
      {required String title, required String description}) {
    showPopUpDialog(
        //text: title,
        isSingleBtn: false,
        textBtn1: LocaleKeys.do_not_allow.tr(),
        onTapBtn1: () {
          // NavigationUtils.getBack();
        },
        text: description,
        textBtn2: LocaleKeys.settings.tr(),
        onTapBtn2: () {
          openAppSettings();
        });
  }
}
