// ignore_for_file: unused_element, library_private_types_in_public_api
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
                left: 30.w,
                right: 30.w,
                child: Container(
                  height: 60.h,
                  width: 310.w,
                  decoration: BoxDecoration(
                    color: AppColor.c1C1C1C,
                    borderRadius: BorderRadius.circular(67.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(AppIcons.homeIcon, "Home", 0),
                      _buildNavItem(AppIcons.wardrobeSvg, "Wardrobe", 1),
                      _buildNavItem(AppIcons.aiSvg, "AI", 2),
                      _buildNavItem(AppIcons.shopSvg, "Shop", 3),
                      _buildNavItem(AppIcons.communitySvg, "Community", 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          // if ((index == 1 || index == 2 || index == 3) &&
          //     !appData.read(kKeyIsLoggedIn)) {
          //   ToastUtil.showLongToast('You need to login first');
          // } else {
          //   selectedIndex = index;
          // }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              selectedIndex == index ? AppColor.cD5E7B0 : AppColor.c7B7B7B,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 12,
              color:
                  selectedIndex == index ? AppColor.cD5E7B0 : AppColor.c7B7B7B,
              fontWeight:
                  selectedIndex == index ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  withValues({required double alpha}) {}
}
