// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/features/community/presentation/all_tab_screen.dart';
import 'package:twwillustration/features/community/presentation/following_screen.dart';
import 'package:twwillustration/features/community/presentation/trending_screen.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key,}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  GetProfileDataModel? profileData;
  int userId = 0;
  bool isLoading = false;

  int selected = 0;
  late final PageController _pageController;

  
  Future<void> fetchProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      bool sucess = await getProfileRxObj.getProfileRx();

      if (sucess) {
        getProfileRxObj.getProfileData.listen((profile) {
          setState(() {
            profileData = profile;
            userId = profileData!.data!.id ?? 0;
          });
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('$error');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
    _pageController = PageController(initialPage: selected);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => selected = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              UIHelper.verticalSpace(60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: SvgPicture.asset(
                      //     AppIcons.backIcon,
                      //     height: 40.h,
                      //     width: 40.w,
                      //   ),
                      // ),
                      SizedBox(width: 40,),
                      Text(
                        'Community',
                        style: TextFontStyle.textStyle20w600c000A15ColorJosefinSans.copyWith(
                          color: Color(0xFF2F2F2F),
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.createPostScreen);
                        },
                        child: SvgPicture.asset(
                          AppIcons.addIcon,
                          height: 40.h,
                          width: 40.w,
                        ),
                      ),
                    ],
                  ),
              UIHelper.verticalSpace(16.h),
              SegmentedFilterBar(
                items: const ['All', 'Trending', 'Following'],
                selectedIndex: selected,
                onChanged: _goTo, // tap korle page e jabe
                onSearchTap: () {},
              ),
              UIHelper.verticalSpaceMedium,
          
              // content area with page swiping
              isLoading ? const Center(child: CircularProgressIndicator()) :
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (i) => setState(() => selected = i),
                  children: [
                    AllTabScreen(),
                    TrendingTabScreen(),
                    FollowingTabScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * Pill-style segmented control with a search button on the right.
class SegmentedFilterBar extends StatelessWidget {
  const SegmentedFilterBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.onSearchTap,
    this.height = 58,
  }) : super(key: key);

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final VoidCallback? onSearchTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    const outerBg = Color(0xFFF0F2F5);
    const selectedBg = Color(0xFFDDECC3);
    const dividerColor = Color(0xFFE3E6EA);
    final textColor = Colors.black.withOpacity(0.8);

    return Container(
      // height: height,
      decoration: BoxDecoration(
        color: outerBg,
        borderRadius: BorderRadius.circular(height),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          // Segments
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.5.h),
              child: Row(
                children: [
                  for (int i = 0; i < items.length; i++) ...[
                    Expanded(
                      child: _Segment(
                        label: items[i],
                        selected: i == selectedIndex,
                        onTap: () => onChanged(i),
                        selectedBg: selectedBg,
                        textColor: textColor,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          // Divider before search
          Container(width: 1,height: 40.h, color: dividerColor),
          // Search icon
          SizedBox(
            width: 56.w,
            child: InkWell(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(height),
              ),
              onTap: onSearchTap,
              child: Center(
                child: Icon(Icons.search, size: 25.sp, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedBg,
    required this.textColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedBg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 9.h),
        decoration: BoxDecoration(
          color: selected ? selectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.black : textColor,
          ),
        ),
      ),
    );
  }
}
