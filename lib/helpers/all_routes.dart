import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:twwillustration/features/FAQ/presentation/faq_screen.dart';
import 'package:twwillustration/features/add_outfit/add_outfit_screen.dart';
import 'package:twwillustration/features/add_outfit/manage_outfit_screen.dart';
import 'package:twwillustration/features/add_outfit/outfit_preview_screen.dart';
import 'package:twwillustration/features/ai_screen/presentation/ai_screen.dart';
import 'package:twwillustration/features/ai_screen/presentation/outfit_suggestion_screen.dart';
import 'package:twwillustration/features/ai_suggestion/presentation/subscription_screen.dart';
import 'package:twwillustration/features/auth/presentation/otp_screen.dart';
import 'package:twwillustration/features/closet/presentation/add_closet_screen.dart';
import 'package:twwillustration/features/block_user/presentation/block_user_screen.dart';
import 'package:twwillustration/features/closet/presentation/closet_details_add_screen.dart';
import 'package:twwillustration/features/closet/presentation/closet_details_screen.dart';
import 'package:twwillustration/features/community/presentation/community_profile_screen.dart';
import 'package:twwillustration/features/community/presentation/report_screen.dart';
import 'package:twwillustration/features/community/widget/create_post_screen.dart';
import 'package:twwillustration/features/fashion_board/add_fashion_board.dart';
import 'package:twwillustration/features/home/presentation/home_screen.dart';
import 'package:twwillustration/features/my_tree/presentation/earn_drop_screen.dart';
import 'package:twwillustration/features/my_tree/presentation/water_drop_log_screen.dart';
import 'package:twwillustration/features/profile/presentation/edit_profile_screen.dart';
import 'package:twwillustration/features/profile/presentation/followers_screen.dart';
import 'package:twwillustration/features/profile/presentation/following_screen.dart';
import 'package:twwillustration/features/profile/presentation/profile_screen.dart';
import 'package:twwillustration/features/quick_stats_screen/quick_stats_screen.dart';
import 'package:twwillustration/features/settings/presentation/settings_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/add_to_shop_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/chat_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/list_successful_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/marketplace_product_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/product_details_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/search_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/wishlist_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/your_marketplace_product_screen.dart';
import 'package:twwillustration/navigation_screen.dart';
import '../features/auth/presentation/forgot_pass_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/reset_pass_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  // ################## Auth User ##################
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String otpScreen = '/otpScreen';
  static const String forgotPassScreen = '/forgotPassScreen';
  static const String resetPassScreen = '/resetPassScreen';

  // * Home Routes
  static const String navigationScreen = '/navigationScreen';
  static const String homeScreen = '/homeScreen';
  static const String outfitSuggestionScreen = '/outfitSuggestionScreen';
  static const String aiScreen = '/aiScreen';
  static const String settingScreen = '/settingScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String followersScreen = '/followersScreen';
  static const String followingScreen = '/followingScreen';
  static const String closetDetailsScreen = '/closetDetailsScreen';
  static const String closetDetailsAddScreen = '/closetDetailsAddScreen';
  static const String blockUserScreen = '/blockUserScreen';
  static const String faqScreen = '/faqScreen';

  // * My Tree Routes
  static const String waterDropLogScreen = '/waterDropLogScreen';
  static const String earnDropScreen = '/earnDropScreen';

  // * Shop Routes
  static const String shopDashboard = '/shopDashboard';
  static const String addToShop = '/addToShop';
  static const String searchScreen = '/searchScreen';
  static const String productDetailsScreen = '/productDetailsScreen';

  // * Community Routes
  static const String communityScreen = '/communityScreen';
  static const String createPostScreen = '/createPostScreen';
  static const String communityProfileScreen = '/communityProfileScreen';
  static const String reportUserScreen = '/reportUserScreen';

  // * Fashion Board Routes
  static const String addInspireBookScreen = '/addInspireBookScreen';

  // * Add Outfit Routes
  static const String manageOutfitScreen = '/manageOutfitScreen';
  static const String addOutfitScreen = '/addOutfitScreen';
  static const String outfitPreview = '/outfitPreview';
  static const String quickStatsScreen = '/quickStatsScreen';
  static const String outfitScreen = '/outfitScreen';
  static const String addClosetScreen = '/addClosetScreen';
  static const String subscriptionScreen = '/subscriptionScreen';
  static const String listSuccessfullScreen = '/listSuccessfullScreen';
  static const String yourMarketplaceProductScreen = '/yourMarketplaceProductScreen';
  static const String wishlistScreen = '/wishlistScreen';
  static const String chatScreen = '/chatScreen';
  static const String marketplaceProductScreen = '/marketplaceProductScreen';

}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NavigationScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => NavigationScreen());

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SignUpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignUpScreen());

      case Routes.otpScreen:
      final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: OtpScreen(
              userEmail: args['userEmail'],
              forgetPass: args['forgetPass'],
            ), settings: settings)
            : CupertinoPageRoute(builder: (context) => OtpScreen(userEmail: args['userEmail'], forgetPass: args['forgetPass'],));

      case Routes.forgotPassScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotPassScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotPassScreen());

      case Routes.resetPassScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ResetPassScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ResetPassScreen());

      // * #################################################################################
      case Routes.homeScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => HomeScreen());

      case Routes.aiScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: AIScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AIScreen());

      case Routes.outfitSuggestionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OutfitSuggestionScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => OutfitSuggestionScreen());

      case Routes.settingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SettingsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SettingsScreen());

      case Routes.profileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: ProfileScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ProfileScreen());

      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => EditProfileScreen());

      case Routes.followersScreen:
      final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FollowersScreen(userId : args['userId']), settings: settings)
            : CupertinoPageRoute(builder: (context) => FollowersScreen(userId : args['userId']));

      case Routes.followingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FollowingScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => FollowingScreen());

      case Routes.closetDetailsScreen:
      final  args = settings.arguments as Map;
       return Platform.isAndroid
        ?  _FadedTransitionRoute(widget: ClosetDetailsScreen(closetId: args['closetId']), settings: settings)
        : CupertinoPageRoute(builder: (context) => ClosetDetailsScreen(closetId: args['closetId']));

      case Routes.closetDetailsAddScreen:
      final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ClosetDetailsAddScreen(imageBytes: args['imageBytes'],), settings: settings)
            : CupertinoPageRoute(builder: (context) => ClosetDetailsAddScreen(imageBytes: args['imageBytes']));

      case Routes.waterDropLogScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WaterDropLogScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => WaterDropLogScreen());

      case Routes.communityProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CommunityProfileScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CommunityProfileScreen());

      case Routes.reportUserScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ReportScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ReportScreen());

      case Routes.earnDropScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EarnDropScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => EarnDropScreen());

      case Routes.addToShop:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddToShopScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AddToShopScreen());

      case Routes.searchScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SearchScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SearchScreen());

      case Routes.productDetailsScreen:
      final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ProductDetailsScreen(productId: args['productId'],), settings: settings)
            : CupertinoPageRoute(builder: (context) => ProductDetailsScreen(productId: args['productId'],));

      case Routes.createPostScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreatePostScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CreatePostScreen());

      case Routes.marketplaceProductScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MarketplaceProductScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => MarketplaceProductScreen());

      case Routes.listSuccessfullScreen:
      final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ListSuccessfulScreen(productId: args['productId'],), settings: settings)
            : CupertinoPageRoute(builder: (context) => ListSuccessfulScreen(productId: args['productId'],));

      case Routes.addInspireBookScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddInspireBookScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AddInspireBookScreen());

      case Routes.manageOutfitScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ManageOutfitScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ManageOutfitScreen());

      case Routes.outfitPreview:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OutfitPreviewScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OutfitPreviewScreen());

      case Routes.quickStatsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: QuickStatsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => QuickStatsScreen());

      case Routes.blockUserScreen:
        return Platform.isAndroid
          ? _FadedTransitionRoute(widget: BlockUserScreen(), settings: settings)
          : CupertinoPageRoute(builder: (context) => BlockUserScreen());

      case Routes.wishlistScreen:
        return Platform.isAndroid
          ? _FadedTransitionRoute(widget: WishlistScreen(), settings: settings)
          : CupertinoPageRoute(builder: (context) => WishlistScreen());

      case Routes.yourMarketplaceProductScreen:
        return Platform.isAndroid
          ? _FadedTransitionRoute(widget: YourMarketplaceProductScreen(), settings: settings)
          : CupertinoPageRoute(builder: (context) => YourMarketplaceProductScreen());

      case Routes.chatScreen:
        return Platform.isAndroid
          ? _FadedTransitionRoute(widget: ChatScreen(), settings: settings)
          : CupertinoPageRoute(builder: (context) => ChatScreen());

      case Routes.faqScreen:
        return Platform.isAndroid
          ? _FadedTransitionRoute(widget: FaqScreen(), settings: settings)
          : CupertinoPageRoute(builder: (context) => FaqScreen());

      case Routes.outfitScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: OutfitScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OutfitScreen());

      case Routes.addClosetScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddClosetScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AddClosetScreen());

      case Routes.subscriptionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SubscriptionScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SubscriptionScreen());

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
