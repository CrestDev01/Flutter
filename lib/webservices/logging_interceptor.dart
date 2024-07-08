import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translations/locale_keys.g.dart';
import '../utils/enum_utils.dart';
import '../utils/functions_utils.dart';

class LoggingInterceptors extends Interceptor {
  BuildContext? context;
  bool logResponse;

  LoggingInterceptors(this.context, {this.logResponse = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugLogText("\n");
    debugLogText(
        "<------------------------------- NEW API CALL ------------------------------------->\n");
    debugLogText("--> BEGIN HTTP\n");
    debugLogText("-------- API Request --------");

    debugLogText(
        "--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}");

    //Header
    if (options.headers.isNotEmpty) {
      debugLogText("=> Headers:");
      options.headers.forEach((k, v) => debugLogText('$k: $v'));
    }

    //Query Params
    if (options.queryParameters.isNotEmpty) {
      debugLogText("=> QueryParameters:");
      options.queryParameters.forEach((k, v) => debugLogText('$k: $v'));
    }

    //Body Data
    if (options.data != null) {
      //If formData multipart
      if (options.data is FormData) {
        //Fields
        Map<String, String> fields = {};
        for (var element in ((options.data) as FormData).fields) {
          fields[element.key] = element.value;
        }
        debugLogText('Multipart Fields: $fields');

        //Files
        Map<String, String> files = {};
        for (var element in ((options.data) as FormData).files) {
          files[element.key] = element.value.filename!;
        }
        debugLogText('Multipart Files: $files');
      }
      //If plain text data
      else {
        debugLogText("=> Body: ${options.data}");
      }
    }
    debugLogText("--> END ${options.method.toUpperCase()}");
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugLogText("\n");
    debugLogText("-------- API Error --------");
    debugLogText("=> Error: $err");

    showToastMessage(context!,
        message: LocaleKeys.something_went_wrong.tr(),
        status: MessageStatusEnum.error);

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugLogText("\n");
    debugLogText("-------- API Response --------");
    debugLogText(
        "<-- ${response.statusCode} (${response.requestOptions.method.toUpperCase()}) ${response.requestOptions.baseUrl}${response.requestOptions.path}");

    //Note : Don't remove
    /*if (!response.headers.isEmpty) {
      debugLogText("Headers:");
      response.headers.forEach((k, v) => debugLogText('$k: $v'));
    }*/

    if (logResponse) {
      debugLogText("=> API Response: ${response.data}");
    }
    debugLogText("<-- END HTTP");
    handler.next(response);
  }
}
