import 'package:rxdart/subjects.dart';
import 'package:twwillustration/features/FAQ/data/get_faq_rx.dart';
import 'package:twwillustration/features/FAQ/model/get_faq_data_model.dart';
import 'package:twwillustration/features/auth/data/login_data/login_rx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_rx.dart';
import 'package:twwillustration/features/auth/data/verify_otp/verify_otp_rx.dart';
import 'package:twwillustration/features/block_user/data/get_block_user/get_block_user_rx.dart';
import 'package:twwillustration/features/block_user/data/toggle_block_unblock/toggle_block_unblock_rx.dart';
import 'package:twwillustration/features/block_user/model/get_block_user_data_model.dart';
import 'package:twwillustration/features/chat/data/get_chat_list/get_chat_list_rx.dart';
import 'package:twwillustration/features/chat/data/get_specific_user_chat/get_specific_user_chat_rx.dart';
import 'package:twwillustration/features/chat/data/send_message/send_message_rx.dart';
import 'package:twwillustration/features/chat/model/get_chat_list_data_model.dart';
import 'package:twwillustration/features/chat/model/get_specific_user_chat_data_model.dart';
import 'package:twwillustration/features/closet/data/add_closet/post_add_closet_rx.dart';
import 'package:twwillustration/features/closet/data/delete_closet/delete_closet_rx.dart';
import 'package:twwillustration/features/closet/data/get_materials/get_materials_rx.dart';
import 'package:twwillustration/features/closet/data/get_single_closet/get_single_closet_rx.dart';
import 'package:twwillustration/features/closet/data/update_closet/update_closet_rx.dart';
import 'package:twwillustration/features/closet/model/get_materilas_data_model.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/features/community/data/add_post/post_add_post_rx.dart';
import 'package:twwillustration/features/community/data/delete_community_post/delete_community_post_rx.dart';
import 'package:twwillustration/features/community/data/get_list_of_post/get_list_of_post_rx.dart';
import 'package:twwillustration/features/community/data/get_post_details/get_post_details_rx.dart';
import 'package:twwillustration/features/community/data/post_comment/post_comment_rx.dart';
import 'package:twwillustration/features/community/data/post_comment_like/post_comment_like_rx.dart';
import 'package:twwillustration/features/community/data/toggle_like_unlike/toggle_like_unlike_rx.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart';
import 'package:twwillustration/features/home/data/get_generet_outfit_filter_data/get_generet_outfit_filter_data_rx.dart';
import 'package:twwillustration/features/home/model/get_generet_outfit_filter_data_model.dart';
import 'package:twwillustration/features/profile/data/edit_profile/edit_profile_rx.dart';
import 'package:twwillustration/features/profile/data/outfits/get_single_outfit/get_single_outfit_rx.dart';
import 'package:twwillustration/features/profile/data/post_follower/post_follower_rx.dart';
import 'package:twwillustration/features/profile/data/get_profile/get_profile_rx.dart';
import 'package:twwillustration/features/profile/data/post_following/post_following_rx.dart';
import 'package:twwillustration/features/profile/data/toggle_follow_unfollow/toggle_follow_unfollow_rx.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
import 'package:twwillustration/features/profile/model/get_single_outfit_data_model.dart';
import 'package:twwillustration/features/settings/data/logout_rx.dart';
import 'package:twwillustration/features/shop_screen/data/add_marketplace/post_add_marketplace_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_product/get_marketplace_product_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_product_details/get_marketplace_product_details_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_wardrobe_filters/get_marketplace_wardrobe_filters_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_wardrobe_product/get_marketplace_wardrobe_product_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_qa_data/get_qa_data_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_wishlist_product/get_wishlist_product_rx.dart';
import 'package:twwillustration/features/shop_screen/data/get_your_marketplace_product/get_your_marketplace_product_rx.dart';
import 'package:twwillustration/features/shop_screen/data/market_place_get_data/market_place_get_data_rx.dart';
import 'package:twwillustration/features/shop_screen/data/post_add_to_cart/post_add_to_cart_rx.dart';
import 'package:twwillustration/features/shop_screen/data/post_ask_question/post_ask_question_rx.dart';
import 'package:twwillustration/features/shop_screen/data/post_ask_question_replay/post_ask_question_replay_rx.dart';
import 'package:twwillustration/features/shop_screen/data/toggle_favorite_unfovarite/toggle_favorite_unfovarite_rx.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_details_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_filters_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_product_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_qa_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_wishlist_product_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_your_marketplace_product.dart';
import 'package:twwillustration/features/shop_screen/model/market_place_get_data_model.dart';
import '../features/profile/data/clothes/get_categories/get_categories_rx.dart';
import '../features/profile/data/clothes/get_single_category/get_single_category_rx..dart';

PostSigninRX postSigninRX = PostSigninRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostSignupRX postSignupRXObj =
    PostSignupRX(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostVerifyOtpRx postVerifyOtpRxObj =
    PostVerifyOtpRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostLogoutRx postLogoutRxObj =
    PostLogoutRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetProfileRx getProfileRxObj =
    GetProfileRx(empty: GetProfileDataModel(), dataFetcher: BehaviorSubject<GetProfileDataModel>());

PostEditProfileRx postEditProfileRxObj =
    PostEditProfileRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostFollowerRx postFollowerRxObj =
    PostFollowerRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostFollowingRx postFollowingRxObj =
    PostFollowingRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

ToggleFollowUnfollowRx toggleFollowUnfollowRxObj =
    ToggleFollowUnfollowRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetCategoriesRx getCategoriesRxObj =
    GetCategoriesRx(empty: GetCategoriesDataModel(), dataFetcher: BehaviorSubject<GetCategoriesDataModel>());

GetSingleCategoryRx getSingleCategoryRxObj = GetSingleCategoryRx(
    empty: GetSingleCategoryDataModel(), dataFetcher: BehaviorSubject<GetSingleCategoryDataModel>());

GetSingleOutfitRx getSingleOutfitRxObj =
    GetSingleOutfitRx(empty: GetSingleOutfitDataModel(), dataFetcher: BehaviorSubject<GetSingleOutfitDataModel>());

GetBlockUserRx getBlockUserRxObj =
    GetBlockUserRx(empty: GetBlockUserDataModel(), dataFetcher: BehaviorSubject<GetBlockUserDataModel>());

ToggleBlockUnblockRx toggleBlockUnblockRxObj =
    ToggleBlockUnblockRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetFaqRx getFaqRxObj = GetFaqRx(empty: GetFAQDataModel(), dataFetcher: BehaviorSubject<GetFAQDataModel>());

GetListOfPostRx getListOfPostRxObj =
    GetListOfPostRx(empty: GetListOfPostDataModel(), dataFetcher: BehaviorSubject<GetListOfPostDataModel>());

ToggleLikeUnlikeRx toggleLikeUnlikeRxObj =
    ToggleLikeUnlikeRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetMaterialsRx getMaterialsRxObj =
    GetMaterialsRx(empty: GetMaterialsDataModel(), dataFetcher: BehaviorSubject<GetMaterialsDataModel>());

PostAddClosetRx postAddClosetRxObj =
    PostAddClosetRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetSingleClosetRx getSingleClosetRxObj =
    GetSingleClosetRx(empty: GetSingleClosetDataModel(), dataFetcher: BehaviorSubject<GetSingleClosetDataModel>());

DeleteClosetRx deleteClosetRxObj =
    DeleteClosetRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

UpdateClosetRx updateClosetRxObj =
    UpdateClosetRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostAddPostRx postAddPostRxObj =
    PostAddPostRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetPostDetailsRx getPostDetailsRxObj =
    GetPostDetailsRx(empty: GetPostDetailsDataModel(), dataFetcher: BehaviorSubject<GetPostDetailsDataModel>());

PostCommentRx postCommentRxObj =
    PostCommentRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostCommentLikeRx postCommentLikeRxObj =
    PostCommentLikeRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

MarketPlaceGetDataRx marketPlaceGetDataRxObj =
    MarketPlaceGetDataRx(empty: MarketPlaceGetDataModel(), dataFetcher: BehaviorSubject<MarketPlaceGetDataModel>());

PostAddMarketplaceRx postAddMarketplaceRxObj =
    PostAddMarketplaceRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetMarketplaceProductDetailsRx getMarketplaceProductDetailsRxObj = GetMarketplaceProductDetailsRx(
    empty: GetMarketplaceProductDetailsModel(), dataFetcher: BehaviorSubject<GetMarketplaceProductDetailsModel>());

GetYourMarketplaceProductRx getYourMarketplaceProductRxObj = GetYourMarketplaceProductRx(
    empty: GetYourMarketplaceProductModel(), dataFetcher: BehaviorSubject<GetYourMarketplaceProductModel>());

GetMarketplaceProductRx getMarketplaceProductRxObj = GetMarketplaceProductRx(
    empty: GetMarketplaceProductModel(), dataFetcher: BehaviorSubject<GetMarketplaceProductModel>());

ToggleFavoriteUnfovariteRx toggleFavoriteUnfovariteRxObj =
    ToggleFavoriteUnfovariteRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetQaDataRx getQaDataRxObj = GetQaDataRx(empty: GetQADataModel(), dataFetcher: BehaviorSubject<GetQADataModel>());

PostAskQuestionRx postAskQuestionRxObj =
    PostAskQuestionRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostAskQuestionReplayRx postAskQuestionReplayRxObj =
    PostAskQuestionReplayRx(empty: <String, dynamic>{}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetChatListRx getChatListRxObj =
    GetChatListRx(empty: GetChatListDataModel(), dataFetcher: BehaviorSubject<GetChatListDataModel>());

GetSpecificUserChatRx getSpecificUserChatRxObj = GetSpecificUserChatRx(
    empty: GetSpecificUserChatDataModel(), dataFetcher: BehaviorSubject<GetSpecificUserChatDataModel>());

GetWishlistProductRx getWishlistProductRxObj = GetWishlistProductRx(
    empty: GetWishlistProductDataModel(), dataFetcher: BehaviorSubject<GetWishlistProductDataModel>());

SendMessageRx sendMessageRxObj = SendMessageRx(empty: {}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetGeneretOutfitFilterDataRx getGeneretOutfitFilterDataRxObj = GetGeneretOutfitFilterDataRx(
    empty: GetGeneretOutfitFilterDataModel(), dataFetcher: BehaviorSubject<GetGeneretOutfitFilterDataModel>());

GetMarketplaceWardrobeFiltersRx getMarketplaceWardrobeFiltersRxObj = GetMarketplaceWardrobeFiltersRx(
    empty: GetMatketplaceWardrobeFiltersDataModel(),
    dataFetcher: BehaviorSubject<GetMatketplaceWardrobeFiltersDataModel>());

GetMarketplaceWardrobeProductRx getMarketplaceWardrobeProductRxObj = GetMarketplaceWardrobeProductRx(
    empty: GetMarketplaceWardrobeProductDataModel(),
    dataFetcher: BehaviorSubject<GetMarketplaceWardrobeProductDataModel>());

PostAddToCartRx postAddToCartRxObj = PostAddToCartRx(empty: {}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

DeleteCommunityPostRx deleteCommunityPostRxObj =
    DeleteCommunityPostRx(empty: {}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());
