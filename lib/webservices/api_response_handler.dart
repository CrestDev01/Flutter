class APIResponseHandler {
  final String responseMessage;
  final dynamic responseData;
  final bool result;
  final int statusCode;

  APIResponseHandler({
    required this.responseData,
    required this.responseMessage,
    required this.result,
    required this.statusCode,
  });

  factory APIResponseHandler.fromMap(
      Map<String, dynamic> map, bool result, int statusCode) {
    return APIResponseHandler(
      responseMessage: map['message'] ?? '',
      responseData: map,
      result: result,
      statusCode: statusCode,
    );
  }
}

class WooAPIResponseHandler {
  final String responseMessage;
  final dynamic responseData;
  final bool result;
  final int statusCode;

  WooAPIResponseHandler({
    required this.responseData,
    required this.responseMessage,
    required this.result,
    required this.statusCode,
  });

  factory WooAPIResponseHandler.fromMap(
      dynamic map, bool result, int statusCode) {
    return WooAPIResponseHandler(
      responseMessage: "",
      responseData: map,
      result: result,
      statusCode: statusCode,
    );
  }
}
