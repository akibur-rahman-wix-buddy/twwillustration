import 'package:rxdart/subjects.dart';
import 'package:twwillustration/features/auth/data/login_data/login_rx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_rx.dart';
import 'package:twwillustration/features/auth/data/verify_otp/verify_otp_rx.dart';
import 'package:twwillustration/features/profile/data/edit_profile/edit_profile_rx.dart';
import 'package:twwillustration/features/profile/data/post_follower/post_follower_rx.dart';
import 'package:twwillustration/features/profile/data/get_profile/get_profile_rx.dart';
import 'package:twwillustration/features/profile/data/post_following/post_following_rx.dart';
import 'package:twwillustration/features/profile/data/toggle_follow_unfollow/toggle_follow_unfollow_rx.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
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
