// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/features/community/presentation/all_tab_screen.dart';
import 'package:twwillustration/features/community/presentation/following_screen.dart';
import 'package:twwillustration/features/community/presentation/trending_screen.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selected = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: CustomAppbar(
        title: 'Community',
        actions: [
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.createPostScreen);
            },
            child: SvgPicture.asset(
              AppIcons.addIcon,
              height: 24.h,
              width: 24.w,
            ),
          ),
          UIHelper.horizontalSpace(25.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SegmentedFilterBar(
                items: const ['All', 'Trending', 'Following'],
                selectedIndex: selected,
                onChanged: _goTo, // tap korle page e jabe
                onSearchTap: () {},
              ),
            ),

            // content area with page swiping
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) => setState(() => selected = i),
                children: const [
                  AllTabScreen(),
                  TrendingTabScreen(),
                  FollowingTabScreen(),
                ],
              ),
            ),
          ],
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
      height: height,
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
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                    if (i != items.length - 1) const SizedBox(width: 6),
                  ]
                ],
              ),
            ),
          ),
          // Divider before search
          Container(width: 1, height: height, color: dividerColor),
          // Search icon
          SizedBox(
            width: height,
            height: height,
            child: InkWell(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(height),
              ),
              onTap: onSearchTap,
              child: const Center(
                child: Icon(Icons.search, size: 22, color: Colors.black87),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? selectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.black : textColor,
          ),
        ),
      ),
    );
  }
}
