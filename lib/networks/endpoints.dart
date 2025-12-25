// ignore_for_file: constant_identifier_names
const String baseUrl = "https://app.mygreendrobe.com/api";

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
  static String logOutUrl() => "/v1/auth/logout";
  static String verifyOtpUrl() => "/v1/verify/otp";
  static String changePassURL() => "/api/password/update";
  static String getAllSongURL() => "/api/audio/all";
  static String getFavouriteSongURL() => "/api/favorites/all";


  ///>>>>>>>>>>>>>>>>>>>>> profile >>>>>>>>>>>>>>>>>>>>>>
  static String editProfileURL() => "/v1/auth/profile";
  static String getProfileURL() => "/v1/auth/profile";
  static String postFavouriteURL() => "/api/favorites/toggle";
  static String getFollowerURL() => "/v1/friendship/follower";
  static String getFollowingURL() => "/v1/friendship/following";
  static String toggleFollowUnfollowURL(int id) => '/v1/friendship/toggle/$id';
  static String getCategoriesURL() => '/v1/closet/categories';
  static String getSingleCategoriesURl(int userId, int? productId) {
    if(productId == null){
      return '/v1/closet?userID=$userId&categoryID=';
    } else{
      return '/v1/closet?userID=$userId&categoryID=$productId';
    }
  } 
  static String getSingleOutfitesURL(int userId, String? category){
    if(category == null){
      return '/v1/outfit?userID=$userId&search=';
    } else{
      return '/v1/outfit?userID=$userId&search=$category';
    }
  }
}