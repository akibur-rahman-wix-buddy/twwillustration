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
import 'package:twwillustration/features/closet/data/add_closet/post_add_closet_rx.dart';
import 'package:twwillustration/features/closet/data/delete_closet/delete_closet_rx.dart';
import 'package:twwillustration/features/closet/data/get_materials/get_materials_rx.dart';
import 'package:twwillustration/features/closet/data/get_single_closet/get_single_closet_rx.dart';
import 'package:twwillustration/features/closet/data/update_closet/update_closet_rx.dart';
import 'package:twwillustration/features/closet/model/get_materilas_data_model.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/features/community/data/get_list_of_post/get_list_of_post_rx.dart';
import 'package:twwillustration/features/community/data/toggle_like_unlike/toggle_like_unlike_rx.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
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
import '../features/profile/data/clothes/get_categories/get_categories_rx.dart';
import '../features/profile/data/clothes/get_single_category/get_single_category_rx..dart';

PostSigninRX postSigninRX = PostSigninRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostSignupRX postSignupRXObj = PostSignupRX(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostVerifyOtpRx postVerifyOtpRxObj = PostVerifyOtpRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostLogoutRx postLogoutRxObj = PostLogoutRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetProfileRx getProfileRxObj = GetProfileRx(
    empty: GetProfileDataModel(),
    dataFetcher: BehaviorSubject<GetProfileDataModel>());

PostEditProfileRx postEditProfileRxObj = PostEditProfileRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostFollowerRx postFollowerRxObj = PostFollowerRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

PostFollowingRx postFollowingRxObj = PostFollowingRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

ToggleFollowUnfollowRx toggleFollowUnfollowRxObj = ToggleFollowUnfollowRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetCategoriesRx getCategoriesRxObj = GetCategoriesRx(
    empty: GetCategoriesDataModel(),
    dataFetcher: BehaviorSubject<GetCategoriesDataModel>());

GetSingleCategoryRx getSingleCategoryRxObj = GetSingleCategoryRx(
    empty: GetSingleCategoryDataModel(),
    dataFetcher: BehaviorSubject<GetSingleCategoryDataModel>());

GetSingleOutfitRx getSingleOutfitRxObj = GetSingleOutfitRx(
    empty: GetSingleOutfitDataModel(),
    dataFetcher: BehaviorSubject<GetSingleOutfitDataModel>());

GetBlockUserRx getBlockUserRxObj = GetBlockUserRx(
    empty: GetBlockUserDataModel(),
    dataFetcher: BehaviorSubject<GetBlockUserDataModel>());

ToggleBlockUnblockRx toggleBlockUnblockRxObj = ToggleBlockUnblockRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetFaqRx getFaqRxObj = GetFaqRx(
    empty: GetFAQDataModel(), dataFetcher: BehaviorSubject<GetFAQDataModel>());

GetListOfPostRx getListOfPostRxObj = GetListOfPostRx(
    empty: GetListOfPostDataModel(),
    dataFetcher: BehaviorSubject<GetListOfPostDataModel>());

ToggleLikeUnlikeRx toggleLikeUnlikeRxObj = ToggleLikeUnlikeRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetMaterialsRx getMaterialsRxObj = GetMaterialsRx(
    empty: GetMaterialsDataModel(),
    dataFetcher: BehaviorSubject<GetMaterialsDataModel>());

PostAddClosetRx postAddClosetRxObj = PostAddClosetRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetSingleClosetRx getSingleClosetRxObj = GetSingleClosetRx(
    empty: GetSingleClosetDataModel(),
    dataFetcher: BehaviorSubject<GetSingleClosetDataModel>());

DeleteClosetRx deleteClosetRxObj = DeleteClosetRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());

UpdateClosetRx updateClosetRxObj = UpdateClosetRx(
    empty: <String, dynamic>{},
    dataFetcher: BehaviorSubject<Map<String, dynamic>>());
