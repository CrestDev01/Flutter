import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:boilerplate/utils/validation_utils.dart';
import '../repository/api_repository.dart';
import '../translations/locale_keys.g.dart';
import '../utils/constant_utils.dart';
import '../utils/enum_utils.dart';
import '../utils/environment_utils.dart';
import '../utils/functions_utils.dart';
import '../utils/preference_utils.dart';
import 'api_http_method.dart';
import 'api_response_handler.dart';
import 'api_urls.dart';
import 'logging_interceptor.dart';
import 'package:mime/mime.dart' as mime;

class APIManager {
  static APIManager? _instance;
  Dio dio = Dio();
  ApiRepository? _apiRepository;
  BuildContext? context;
  LoggingInterceptors? loggingInterceptors;

  APIManager._internal() {
    _instance = this;
    _apiRepository = ApiRepository();
    loggingInterceptors = LoggingInterceptors(context);
    _instance!._initDio();
  }

  factory APIManager() => _instance ?? APIManager._internal();

  static APIManager get shared => APIManager();

  //Initialize Dio
  _initDio() {
    BaseOptions options = BaseOptions(
        connectTimeout: const Duration(milliseconds: 50000),
        receiveTimeout: const Duration(milliseconds: 30000),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return (status ?? 0) < 500;
        },
        baseUrl: APIUrls.baseURL + APIUrls.apiVersion);
    dio.interceptors.add(loggingInterceptors!);
    dio.options = options;
  }
}

extension APICallExt on APIManager {
  //API call request
  Future<APIResponseHandler?> callAPI({
    required String endpoint,
    String?
        pathParamUrl, //Pass params in url as path (Create endpoint with path params)
    dynamic requestData,
    Map<String, dynamic>? queryParameters,
    String? httpMethod, //Have to pass method only if endpoint is duplicate
    bool logResponse = true,
  }) async {
    loggingInterceptors?.logResponse = logResponse;

    bool isConnected = await checkConnectivity(context!);

    if (!isConnected) {
      return null;
    }

    //All http method requests are being called from here
    Response? response;

    try {
      response = await dio.request(pathParamUrl ?? endpoint,
          data: requestData,
          queryParameters: queryParameters,
          options: Options(
              method: httpMethod ?? APIHttpMethod.getHttpMethod(endpoint),
              headers: _getHeaders(endpoint)));
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        showToastMessage(context!,
            message: LocaleKeys.connection_timeout.tr(),
            status: MessageStatusEnum.error);
        debugLogText('Connection Timeout');
      } else if (ex.type == DioExceptionType.unknown) {
        showToastMessage(context!,
            message: LocaleKeys.something_went_wrong.tr(),
            status: MessageStatusEnum.error);
        debugLogText('Something went wrong');
      } else {
        showToastMessage(context!,
            title: ex.type.name.returnString(),
            message: ex.message.returnString(),
            status: MessageStatusEnum.error);
        debugLogText('${ex.type.name} => ${ex.message}');
      }
    }
    if (response != null) {
      return _getResponse(response); //Retrieve API response
    } else {
      return APIResponseHandler(
          responseData: null,
          responseMessage: LocaleKeys.something_went_wrong.tr(),
          result: false,
          statusCode: -1);
    }
  }

  Future<WooAPIResponseHandler?> callWooCommerceAPI({
    required String endpoint,
    String?
        pathParamUrl, //Pass params in url as path (Create endpoint with path params)
    dynamic requestData,
    Map<String, dynamic>? queryParameters,
    String? httpMethod, //Have to pass method only if endpoint is duplicate
    bool logResponse = true,
  }) async {
    loggingInterceptors?.logResponse = logResponse;

    bool isConnected = await checkConnectivity(context!);

    if (!isConnected) {
      return null;
    }
    final dio = Dio(BaseOptions(
      baseUrl: Environment.url,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 30000),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      queryParameters: {
        ParameterUtils.CONSUMERKEY: Environment.consumerKey,
        ParameterUtils.CONSUMERSECRET: Environment.consumerSecret,
      },
    ));

    //All http method requests are being called from here
    Response? response;

    try {
      response = await dio.request(pathParamUrl ?? endpoint,
          data: requestData,
          queryParameters: queryParameters,
          options: Options(
              method: httpMethod ?? APIHttpMethod.getHttpMethod(endpoint),
              headers: _getHeaders(endpoint)));
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        showToastMessage(context!,
            message: LocaleKeys.connection_timeout.tr(),
            status: MessageStatusEnum.error);
        debugLogText('Connection Timeout');
      } else if (ex.type == DioExceptionType.unknown) {
        showToastMessage(context!,
            message: LocaleKeys.something_went_wrong.tr(),
            status: MessageStatusEnum.error);
        debugLogText('Something went wrong');
      } else {
        showToastMessage(context!,
            title: ex.type.name.returnString(),
            message: ex.message.returnString(),
            status: MessageStatusEnum.error);
        debugLogText('${ex.type.name} => ${ex.message}');
      }
    }

    if (response != null) {
      return _getWooResponse(response); //Retrieve API response
    } else {
      return WooAPIResponseHandler(
          responseData: null,
          responseMessage: LocaleKeys.something_went_wrong.tr(),
          result: false,
          statusCode: -1);
    }
  }

  //API headers
  Map<String, dynamic>? _getHeaders(String endpoint) {
    switch (endpoint) {
      case APIUrls.signIn:
        return {
          'x-api-key': APIUrls.xApiKey,
          'Accept': "application/json",
        };

      case APIUrls.forgetPasswordVerifyEmail:
      case APIUrls.forgetPasswordVerifyOtp:
        return {
          'Accept': "application/json",
        };
      default:
        return {
          HttpHeaders.authorizationHeader: "Bearer ${getBearerToken()}",
          "Accept": "application/json",
        };
    }
  }

  //Get multipart file
  /*Future<MultipartFile> getMultipartFile(File file) async {
    String fileName = file.path.split('/').last;

    return await MultipartFile.fromFile(file.path, filename: fileName);
  }*/

  Future<MultipartFile> getMultipartFile(File file) async {
    final mimeType =
        mime.lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');

    String fileName = file.path.split('/').last;

    return await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType(
        mimeType![0],
        mimeType[1],
      ),
    );
  }

  //Prepare formData object
  dynamic prepareFormDataOld(File file) async {
    return FormData.fromMap({
      'name': 'Test',
      'age': 25,
      'file': await getMultipartFile(file),
      'files': [
        await getMultipartFile(file),
        await getMultipartFile(file),
        await getMultipartFile(file),
      ]
    });
  }

  dynamic prepareFormData({required Map<String, dynamic> map}) {
    return FormData.fromMap(map);
  }
}

extension on APIManager {
  //Get API response
  APIResponseHandler? _getResponse(Response response) {
    var responseBody = response.data;

    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
      case 403:
      case 404:
      case 405:
      case 409:
      case 422:
        APIResponseHandler apiResponseHandler = APIResponseHandler.fromMap(
            responseBody, responseBody['status'], response.statusCode!);
        return apiResponseHandler;
      case 401:
        // PreferenceUtils.shared.removeKey(key: PreferenceKeys.userData);
        // PreferenceUtils.shared.removeKey(key: PreferenceKeys.isLogin);
        // PreferenceUtils.shared.removeKey(key: PreferenceKeys.authToken);
        // NavigationUtils.getOffAll(const SignInScreen(showBackArrow: false))
        //     .then((value) {
        //   BlocUtils(context: context).getCheckListBloc(clearBloc: true);
        // });

        APIResponseHandler apiResponseHandler = APIResponseHandler.fromMap(
            responseBody, false, response.statusCode!);
        return apiResponseHandler;
      case 500:
        return APIResponseHandler(
            responseData: null,
            responseMessage: LocaleKeys.internal_server_err.tr(),
            result: false,
            statusCode: response.statusCode!);
      default:
        return APIResponseHandler(
            responseData: null,
            responseMessage: LocaleKeys.something_went_wrong.tr(),
            result: false,
            statusCode: -1);
    }
  }

  WooAPIResponseHandler? _getWooResponse(Response response) {
    var responseBody = response.data;

    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
      case 403:
      case 404:
      case 405:
      case 409:
      case 422:
        WooAPIResponseHandler apiResponseHandler =
            WooAPIResponseHandler.fromMap(
                responseBody, true, response.statusCode!);
        return apiResponseHandler;
      case 401:
        if (responseBody['message'].toString().toLowerCase() ==
            ConstantUtils.authError.toLowerCase()) {
          _apiRepository?.context = context;
          /*_apiRepository?.logoutSuccessCall(
              message: LocaleKeys.session_expired.tr);*/
        }

        WooAPIResponseHandler apiResponseHandler =
            WooAPIResponseHandler.fromMap(
                responseBody, false, response.statusCode!);
        return apiResponseHandler;
      case 500:
        return WooAPIResponseHandler(
            responseData: null,
            responseMessage: LocaleKeys.internal_server_err.tr(),
            result: false,
            statusCode: response.statusCode!);
      default:
        return WooAPIResponseHandler(
            responseData: null,
            responseMessage: LocaleKeys.something_went_wrong.tr(),
            result: false,
            statusCode: -1);
    }
  }
}
