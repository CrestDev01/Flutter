import 'api_urls.dart';

class APIHttpMethod {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
  static const String put = 'PUT';

  //Get API http method
  static String getHttpMethod(String endpoint) {
    switch (endpoint) {
      //............. POST .............
      case APIUrls.signIn:
        return post;
    }
    return get;
  }
}
