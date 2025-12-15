// ignore_for_file: constant_identifier_names
const String baseUrl = "https://admin.numynd.app/api";

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

class Endpoints {
  Endpoints._();

  ///>>>>>>>>>>>>>>>>>>>>> auth and forget >>>>>>>>>>>>>>>>>>>>>>>>>
  static String logInUrl() => "/v1/login";
  static String signUpUrl() => "/v1/sign-up";
  static String logOutUrl() => "/api/logout";
  static String verifyOtpUrl() => "/v1/verify/otp";
  static String changePassURL() => "/api/password/update";
  static String getAllSongURL() => "/api/audio/all";
  static String getFavouriteSongURL() => "/api/favorites/all";
  static String updateProfileURL() => "/api/profile/update";
  static String getProfileURL() => "/api/profile";
  static String postFavouriteURL() => "/api/favorites/toggle";
}