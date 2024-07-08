class APIUrls {
  //Base Url
  static String baseURL = devURL;
  static String xApiKey =
      "HUXZ0mOi6r0B165kGMdpL1BVpWXpErRXsjf4hR0C4Z0Ml0GhozCenMwXwzGO4y4x";

  static String prodURL = 'PROD URL HERE';
  static String devURL = 'DEV URL HERE';

  static String apiVersion = '/api/';

  //Url Endpoints (Common Urls)
  static const String signIn = 'user/login';
  static const String forgetPasswordVerifyEmail = 'user/forgot-pasword';
  static const String forgetPasswordVerifyOtp = 'user/verify-otp';
  static const String logout = 'project/token/logout';
}
