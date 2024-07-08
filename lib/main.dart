import 'package:flutter/material.dart';

import '../model/global/app_config_model.dart';
import '../utils/enum_utils.dart';
import '../utils/functions_utils.dart';
import 'app/app.dart';

/// The main function of the application.
///
/// This function is the entry point of the application and is executed when the
/// application starts. It initializes the application by creating an instance of
/// the [AppConfig] class with the provided app name and flavor. Then, it calls
/// the [initializeApp] function to initialize the application and returns a
/// [Widget] that represents the root of the application. Finally, it runs the
/// application by calling the [runApp] function with the [Widget] returned by
/// [initializeApp].
///
/// This function does not take any parameters.
///
/// This function does not return any values.
void main() async {
  debugLogText('Called Main Function.................');
  AppConfig devAppConfig =
      AppConfig(appName: "App name", flavor: FlavorEnum.dev.value);
  Widget app = await initializeApp(
    appConfig: devAppConfig,
  );

  runApp(app);
}
