// ignore_for_file: unused_element, library_private_types_in_public_api
import 'package:elysian_nav/elysian_nav.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/features/ai_screen/presentation/ai_screen.dart';
import 'package:twwillustration/features/community/presentation/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twwillustration/features/home/presentation/home_screen.dart';
import 'package:twwillustration/features/shop_screen/presentation/shop_dashboard_screen.dart';
import 'package:twwillustration/features/wardrobe/presentation/wardrobe_screen.dart';
import 'assets_helper/app_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool showOverlay = true;
  int selectedIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    _checkFirstTime();
    super.initState();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOverlay = prefs.getBool("hasSeenOverlay") ?? false;

    setState(() {
      showOverlay = !hasSeenOverlay;
    });
  }

  Future<void> _hideOverlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasSeenOverlay", true);

    setState(() {
      showOverlay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              IndexedStack(
                index: selectedIndex,
                children: [
                  const HomeScreen(),
                  const WardrobeScreen(),
                  const AIScreen(),
                  const ShopDashboardScreen(),
                  const CommunityScreen(),
                ],
              ),
              Positioned(
                  bottom: 10.h,
                  left: 16.w,
                  right: 16.w,
                  child: ElysianNav(
                      padding: EdgeInsets.zero,
                      currentIndex: selectedIndex,
                      onTap: (index) => setState(() {
                            selectedIndex = index;
                          }),
                      selectedLabelStyle: TextFontStyle.inter10W600.copyWith(color: AppColor.cD5E7B0),
                      unselectedLabelStyle: TextFontStyle.inter10W400.copyWith(color: AppColor.c7B7B7B),
                      selectedItemColor: AppColor.cD5E7B0,
                      backgroundColor: AppColor.c1C1C1C,
                      items: [
                        ElysianNavItem(
                            icon: SvgPicture.asset(AppIcons.homeIcon,
                                colorFilter: ColorFilter.mode(AppColor.c7B7B7B, BlendMode.srcIn)),
                            activeIcon: SvgPicture.asset(AppIcons.homeIcon,
                                colorFilter: ColorFilter.mode(AppColor.cD5E7B0, BlendMode.srcIn)),
                            label: 'Home'),
                        ElysianNavItem(
                            icon: SvgPicture.asset(AppIcons.wardrobeSvg,
                                colorFilter: ColorFilter.mode(AppColor.c7B7B7B, BlendMode.srcIn)),
                            activeIcon: SvgPicture.asset(AppIcons.wardrobeSvg,
                                colorFilter: ColorFilter.mode(AppColor.cD5E7B0, BlendMode.srcIn)),
                            label: 'Wardrobe'),
                        ElysianNavItem(
                            icon: SvgPicture.asset(AppIcons.aiSvg,
                                colorFilter: ColorFilter.mode(AppColor.c7B7B7B, BlendMode.srcIn)),
                            activeIcon: SvgPicture.asset(AppIcons.aiSvg,
                                colorFilter: ColorFilter.mode(AppColor.cD5E7B0, BlendMode.srcIn)),
                            label: 'AI'),
                        ElysianNavItem(
                            icon: SvgPicture.asset(AppIcons.shopSvg,
                                colorFilter: ColorFilter.mode(AppColor.c7B7B7B, BlendMode.srcIn)),
                            activeIcon: SvgPicture.asset(AppIcons.shopSvg,
                                colorFilter: ColorFilter.mode(AppColor.cD5E7B0, BlendMode.srcIn)),
                            label: 'Shop'),
                        ElysianNavItem(
                            icon: SvgPicture.asset(AppIcons.communitySvg,
                                colorFilter: ColorFilter.mode(AppColor.c7B7B7B, BlendMode.srcIn)),
                            activeIcon: SvgPicture.asset(AppIcons.communitySvg,
                                colorFilter: ColorFilter.mode(AppColor.cD5E7B0, BlendMode.srcIn)),
                            label: 'Community'),
                      ])),
            ],
          ),
        ),
      ],
    );
  }
}
