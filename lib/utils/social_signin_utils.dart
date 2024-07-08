// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';

// import 'package:exam_easy_app/model/global/error_model.dart';
// import 'package:exam_easy_app/translations/locale_keys.g.dart';
// import 'package:exam_easy_app/utils/enum_utils.dart';
// import 'package:exam_easy_app/utils/functions_utils.dart';
// import 'package:exam_easy_app/utils/validation_utils.dart';
// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:tuple/tuple.dart';

// // import '../model/error_model.dart';
// // import 'function_utils.dart';

// class SocialSignInUtils {
//   //Google SignIn
//   static Future<Tuple2<String?, ErrorModel?>> googleSignIn(
//       BuildContext context) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     if (Platform.isAndroid) {
//       await googleSignIn.signOut();
//     }
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     ErrorModel? errorModel;
//     String? token;
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       token = googleSignInAuthentication.accessToken;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);
//         user = userCredential.user;
//         /*final token = await user!.getIdToken();*/
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           //Show toast
//         } else if (e.code == 'invalid-credential') {
//           showToastMessage(context,
//               message: "Invalid Credentials", status: MessageStatusEnum.error);
//         }
//       } catch (error) {
//         print(error.toString());
//       }
//     } else {
//       showToastMessage(context,
//           message: LocaleKeys.try_again_after_some_time.tr(),
//           status: MessageStatusEnum.error);
//     }

//     return Tuple2(token, errorModel);
//   }

//   //Facebook SignIn
//   static Future<Tuple3<UserCredential?, ErrorModel?, String?>> facebookSignIn(
//       BuildContext context) async {
//     late LoginResult loginResult;
//     UserCredential? userCredential;
//     ErrorModel? errorModel;
//     String? token;
//     await FacebookAuth.instance.login().then((value) async {
//       loginResult = value;
//       if (!isNullEmptyOrFalse(loginResult.accessToken)) {
//         if (!isNullEmptyOrFalse(loginResult.accessToken!.token)) {
//           token = loginResult.accessToken!.token;
//         }
//       }
//     }).catchError((error) {
//       DioException err = error;
//       debugPrintText("Error := ${err.response}");
//     }).onError((error, stackTrace) {
//       debugPrintText("Error  : = $error , $stackTrace");
//     });
//     if (!isNullEmptyOrFalse(token)) {
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(token ?? "");
//       await FirebaseAuth.instance
//           .signInWithCredential(facebookAuthCredential)
//           .then((value) {
//         userCredential = value;
//       }).catchError((e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           showToastMessage(context,
//               message: LocaleKeys.account_already_exist.tr(),
//               status: MessageStatusEnum.error);
//         } else if (e.code == 'invalid-credential') {
//           showToastMessage(context,
//               message: LocaleKeys.invalid_credentials.tr(),
//               status: MessageStatusEnum.error);
//         }
//       });
//       bool isEmailAvailable = false;
//       if (!isNullEmptyOrFalse(userCredential)) {
//         if (!isNullEmptyOrFalse(userCredential!.additionalUserInfo)) {
//           if (!isNullEmptyOrFalse(
//               userCredential!.additionalUserInfo!.profile)) {
//             if (!isNullEmptyOrFalse(
//                 userCredential!.additionalUserInfo!.profile!["email"])) {
//               isEmailAvailable = true;
//             }
//           }
//         }
//       }

//       if (!isEmailAvailable) {
//         userCredential = null;
//         token = "";
//         errorModel = ErrorModel(
//             status: 500, message: LocaleKeys.email_not_available.tr());
//       }
//     }

//     return Tuple3(userCredential, errorModel, token);
//   }

//   //Apple SignIn
// //   static Future<Tuple2<UserCredential?, ErrorModel?>> appleSignIn(
// //       BuildContext context) async {
// //     final firebaseAuth = FirebaseAuth.instance;
// //     UserCredential? userCredential;
// //     ErrorModel? errorModel;

// //     final rawNonce = generateNonce();
// //     final nonce = sha256ofString(rawNonce);

// //     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
// //       AppleIDAuthorizationScopes.email,
// //       AppleIDAuthorizationScopes.fullName,
// //     ], nonce: nonce);

// //     final oauthCredential = OAuthProvider("apple.com").credential(
// //       idToken: credential.identityToken,
// //       rawNonce: rawNonce,
// //     );
// //     await firebaseAuth.signInWithCredential(oauthCredential).then((value) {
// //       userCredential = value;
// //     }).catchError((e) {
// //       if (e.code == 'account-exists-with-different-credential') {
// //         showToastMessage(context,
// //             message:
// //                 getTranslate(context, "error_message.account_already_exists"),
// //             status: MessageStatus.error);
// //       } else if (e.code == 'invalid-credential') {
// //         showToastMessage(context,
// //             message: getTranslate(context, "error_message.invalid_credentials"),
// //             status: MessageStatus.error);
// //       }
// //     });

// //     final firebaseUser = userCredential?.user;
// //     String token = await firebaseUser?.getIdToken() ?? "";
// //     debugPrintText("Firebase token :=  $token");
// //     return Tuple2(userCredential, errorModel);
// //   }
// }
