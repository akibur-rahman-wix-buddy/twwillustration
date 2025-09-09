import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:twwillustration/features/ai_screen/presentation/ai_screen.dart';
import 'package:twwillustration/features/ai_screen/presentation/outfit_suggestion_screen.dart';
import 'package:twwillustration/features/auth/presentation/otp_screen.dart';
import 'package:twwillustration/features/closet_details/presentation/closet_details_screen.dart';
import 'package:twwillustration/features/home/presentation/home_screen.dart';
import 'package:twwillustration/features/my_tree/presentation/water_drop_log_screen.dart';
import 'package:twwillustration/features/profile/presentation/edit_profile_screen.dart';
import 'package:twwillustration/features/profile/presentation/followers_screen.dart';
import 'package:twwillustration/features/profile/presentation/following_screen.dart';
import 'package:twwillustration/features/profile/presentation/profile_screen.dart';
import 'package:twwillustration/features/settings_screen.dart';
import '../features/auth/presentation/forgot_otp_screen.dart';
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
  static const String forgotOtpScreen = '/forgotOtpScreen';
  static const String resetPassScreen = '/resetPassScreen';

  // * Home Routes
  static const String homeScreen = '/homeScreen';
  static const String outfitSuggestionScreen = '/outfitSuggestionScreen';
  static const String aiScreen = '/aiScreen';
  static const String settingScreen = '/settingScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String followersScreen = '/followersScreen';
  static const String followingScreen = '/followingScreen';
  static const String closetDetailsScreen = '/closetDetailsScreen';

  // * My Tree Routes
  static const String waterDropLogScreen = '/waterDropLogScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SignUpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignUpScreen());

      case Routes.otpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: OtpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OtpScreen());

      case Routes.forgotPassScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotPassScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotPassScreen());

      case Routes.forgotOtpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotOtpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotOtpScreen());

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
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FollowersScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => FollowersScreen());

      case Routes.followingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FollowingScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => FollowingScreen());

      case Routes.closetDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ClosetDetailsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ClosetDetailsScreen());

      case Routes.waterDropLogScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WaterDropLogScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => WaterDropLogScreen());

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
