//NOTE:
///ApiRepository is used as a global domain for if in case we need to use any API from multiple screens,
///we can access it from ApiRepository directly by writing API calls only once

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:boilerplate/model/auth/login_model.dart';
import 'package:boilerplate/model/main/safety_buddy_model.dart';
import 'package:tuple/tuple.dart';

import '../model/global/error_model.dart';
import '../model/global/success_model.dart';
import '../webservices/api_http_method.dart';
import '../webservices/api_manager.dart';
import '../webservices/api_response_handler.dart';
import '../webservices/api_urls.dart';

class ApiRepository {
  BuildContext? context;

  ApiRepository._({this.context});

  factory ApiRepository({BuildContext? context}) {
    APIManager.shared.context = context;
    return ApiRepository._(context: context);
  }
}

//Auth
extension AuthAPIExt on ApiRepository {
  Future<Tuple3<LoginSuccessModel?, ErrorModel?, bool>?> userSignIn({
    required Map<String, dynamic> bodyData,
  }) async {
    APIResponseHandler? handler = await APIManager.shared.callAPI(
      endpoint: APIUrls.signIn,
      requestData: bodyData,
    );

    if (handler == null) {
      return null;
    }

    LoginSuccessModel? userModel = handler.responseData != null
        ? LoginSuccessModel.fromJson(handler.responseData)
        : handler.responseData;

    ErrorModel? errorModel = userModel != null && handler.statusCode == 200
        ? ErrorModel.fromJson(userModel.toJson())
        : ErrorModel(
            status: handler.statusCode == 200,
            message: handler.responseMessage);

    return Tuple3(userModel, errorModel, handler.result);
  }

  //__Forgot password (API call)__
  Future<Tuple3<SuccessModel?, ErrorModel?, bool>?> forgotPassword({
    required String email,
  }) async {
    APIResponseHandler? handler = await APIManager.shared.callAPI(
      endpoint: APIUrls.forgetPasswordVerifyEmail,
      httpMethod: APIHttpMethod.post,
      requestData: {'email': email},
    );

    if (handler == null) {
      return null;
    }

    SuccessModel? model = handler.responseData != null
        ? SuccessModel.fromJson(handler.responseData)
        : handler.responseData;

    ErrorModel? errorModel = model != null
        ? ErrorModel.fromJson(model.toJson())
        : ErrorModel(
            status: handler.statusCode == 200,
            message: handler.responseMessage);

    return Tuple3(model, errorModel, handler.result);
  }

  //__Forgot password (API call)__
  Future<Tuple3<SuccessModel?, ErrorModel?, bool>?> verifyOtp({
    required String email,
    required String otp,
    required String password,
  }) async {
    APIResponseHandler? handler = await APIManager.shared.callAPI(
      endpoint: APIUrls.forgetPasswordVerifyOtp,
      httpMethod: APIHttpMethod.post,
      requestData: {
        'email': email,
        'otp': otp,
        'password': password,
      },
    );

    if (handler == null) {
      return null;
    }

    SuccessModel? model = handler.responseData != null
        ? SuccessModel.fromJson(handler.responseData)
        : handler.responseData;

    ErrorModel? errorModel = model != null
        ? ErrorModel.fromJson(model.toJson())
        : ErrorModel(
            status: handler.statusCode == 200,
            message: handler.responseMessage);

    return Tuple3(model, errorModel, handler.result);
  }

  //__Logout user (API call)__
  Future<Tuple3<SuccessModel?, ErrorModel?, bool>?> logout({
    required String deviceId,
  }) async {
    APIResponseHandler? handler = await APIManager.shared.callAPI(
      endpoint: APIUrls.logout,
      httpMethod: APIHttpMethod.delete,
      queryParameters: {'device_id': deviceId},
    );

    if (handler == null) {
      return null;
    }

    SuccessModel? successModel = handler.responseData != null
        ? SuccessModel.fromJson(handler.responseData)
        : handler.responseData;

    ErrorModel? errorModel = successModel != null
        ? ErrorModel.fromJson(successModel.toJson())
        : ErrorModel(
            status: handler.statusCode == 200,
            message: handler.responseMessage);

    return Tuple3(successModel, errorModel, handler.result);
  }
}
