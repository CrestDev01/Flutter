// import 'package:exam_easy_app/utils/firebase_utils.dart';
// import 'package:exam_easy_app/utils/validation_utils.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationUtils {
//   static NotificationUtils? _instance;

//   NotificationUtils._internal() {
//     _instance = this;
//   }

//   factory NotificationUtils() => _instance ?? NotificationUtils._internal();

//   static NotificationUtils get shared => NotificationUtils();
// }

// extension NotificationExt on NotificationUtils {
//   Future<void> setupNotifications() async {
//     await _setupFirebaseNotifications();
//   }
// }

// extension FirebaseNotificationExt on NotificationUtils {
//   //Setup firebase notification
//   Future<void> _setupFirebaseNotifications() async {
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       sound: true,
//       badge: true,
//     );

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {});
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });

//     FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
//   }

//   @pragma('vm:entry-point')
//   Future<void> backgroundMessageHandler(RemoteMessage message) async {
//     if (!isNullEmptyOrFalse(message)) {
//       WidgetsFlutterBinding.ensureInitialized();

//       FirebaseUtils.shared.initFirebase();
//     }
//   }
// }
