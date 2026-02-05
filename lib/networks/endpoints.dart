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
  static String getBlockUsreURl(String? search){
    if(search == null){
      return '/v1/user/blocked?search=&page&per_page';
    } else{
      return '/v1/user/blocked?search=$search&page&per_page';
    }
  }
  static String toggleBlockUnblockURL(int id) => '/v1/user/$id/toggle-block';
  static String getFAQURL() => '/v1/setting/faqs';
  static String getListOfPostURL(String? search, String? filter) {
    if(search != null){
      return '/v1/community/posts?search=$search&filter=&page&per_page';
    } else if(filter != null){
      return '/v1/community/posts?search=&filter=$filter&page&per_page';
    } else{
      return '/v1/community/posts?search=&filter=&page&per_page';
    }
  }
  static String toggleLikeUnlikeURL(int postId) => '/v1/community/post/$postId/like';
  static String getMaterialsURL() => '/v1/closet/materials';
  static String postAddClosetURL() => '/v1/closet/store';
  static String getSingleClosetURl(int closetId) => '/v1/closet/show/$closetId';
  static String postUpdateClosetURL(int closetId) => '/v1/closet/update/$closetId';
  static String deleteClosetURL(int closetId) => '/v1/closet/delete/$closetId';
  static String postAddPostURL() => '/v1/community/post';
  static String getPostDetailsURL(int postId) => '/v1/community/post/$postId';
  static String postCommentURL(int postId) => '/v1/community/post/$postId/comment';
  static String postCommentLikeURL(int commentId) => '/v1/community/comment/$commentId/like-toggle';
  static String marketPlaceGetDataURL() => '/v1/marketplace/get-data';
  static String postAddMarketplaceURL() => '/v1/marketplace/add-item';
  static String toggleProductFavoriteUnfovartieURL() => '/v1/marketplace/favorites/toggle';
  static String getMarketplaceProductDetailsURL(int productId) => '/v1/marketplace/details/$productId';
  static String getQADataURL(int productId) => '/v1/marketplace/product-questions/$productId';
  static String postAskQuestionURL() => '/v1/marketplace/product-questions';
  static String postAskQuestionReplayURL() => '/v1/marketplace/product-questions/store/answer';
  static String getYourMarketplaceProductURL() => '/v1/marketplace/my-products?search&page&per_page=1000';
  static String getMarketplaceProductURL(String? category, String? search) => '/v1/marketplace?category=$category&search=$search&page=1&per_page=1000';
  static String getChatListURL(String? search) => '/v1/marketplace/conversation/list?search=$search&page&per_page=1000';
  static String getSpecificUserChatURL(int usreId) => '/v1/marketplace/conversation/details/$usreId';
  static String getWishlistProductURL() => '/v1/marketplace/favorites?page=1&per_page=1000';
  static String postSendMessageURL() => '/v1/marketplace/conversation/send';
  static String getGeneretOutfitDataURL() => '/v1/home/outfits/generate/filters';
  static String getMarketplacrWardrobeFiltersURL() => '/v1/marketplace/wardrobe/filters';
  static String getMarketplaceWardrobeProductURL(String? type) => '/v1/marketplace/wardrobe?type=$type';
  static String postAddTOCartURL() => '/v1/marketplace/cart/add';
}