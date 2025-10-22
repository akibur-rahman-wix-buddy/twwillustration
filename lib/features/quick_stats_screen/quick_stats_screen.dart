// * ==========================================================================
// ignore_for_file: deprecated_member_use
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class QuickStatsScreen extends StatefulWidget {
  const QuickStatsScreen({super.key});

  @override
  State<QuickStatsScreen> createState() => _QuickStatsScreenState();
}

class _QuickStatsScreenState extends State<QuickStatsScreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = [
    "Overview",
    "Wear Frequency",
    "Sustainability",
    "Cost Analysis"
  ];

  final List<Color> _tabColors = [
    const Color(0xFFCDEAB3),
    const Color(0xFFF7CBA3),
    const Color(0xFFF3A6A6),
    const Color(0xFFAAD5F3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(title: 'My Wardrobe Stats'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Chips Section
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tabs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: _buildChip(
                            _tabs[index],
                            _tabColors[index],
                            isSelected: _selectedIndex == index,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                UIHelper.verticalSpaceMedium,

                // 🔹 If Overview selected → show all data
                if (_selectedIndex == 0) _buildOverviewContent(),

                // 🔹 Else → show empty state
                if (_selectedIndex == 1) _buildWearFrequencyContent(),
                if (_selectedIndex == 2) _buildSustainabilityContent(),
                if (_selectedIndex == 3) _buildCostAnalysisContent(),

                // _buildEmptyState(_tabs[_selectedIndex]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔸 Reusable Chip
  Widget _buildChip(String label, Color color, {bool isSelected = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(1) : color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: isSelected ? Colors.black54 : Colors.transparent,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // * 🔹 Empty Placeholder for other tabs
  Widget _buildWearFrequencyContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sustainability Impact',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Contribution to sustainable fashion',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Item Reused',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Sustainable Materials',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Ethical Brands',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item Sold',
                      style: TextFontStyle
                          .textStyle14w500SecondaryColorJosefinSans
                          .copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item Sold',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Value: \$320',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // * 🔹 Empty Placeholder for other tabs
  Widget _buildSustainabilityContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200, width: 0.5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Most Worn Items',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Contribution to sustainable fashion',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(25.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Black Jeans',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '48 wears',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                  UIHelper.verticalSpace(5.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 60 / 100,
                      minHeight: 16,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColors,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(25.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'White',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '48 wears',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                  UIHelper.verticalSpace(5.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 60 / 100,
                      minHeight: 16,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColors,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(25.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Denim',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '48 wears',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                  UIHelper.verticalSpace(5.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 60 / 100,
                      minHeight: 16,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColors,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(15.h),
                  Text(
                    'View All',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColors,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        UIHelper.verticalSpaceMedium,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unworn Items(90+ days)',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColors,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '42 Items',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                UIHelper.verticalSpace(10.h),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.errorIcon),
                        UIHelper.horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Red Dress',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Last worn: 120 days ago',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.verticalSpace(10.h),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.errorIcon),
                        UIHelper.horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Blazer',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Last worn: 120 days ago',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.verticalSpace(10.h),
                Text(
                  'View All',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        UIHelper.verticalSpaceMedium,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200, width: 0.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Title
                Text(
                  "Suggested Next Item to Wear",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),

                // 🔹 Outfit Row
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/6804/6804967.png",
                            height: 60.h,
                            width: 60.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Outfit Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Navy Blue Sweater",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                "Last worn: 145 days ago",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "Perfect for today’s weather",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // 🔹 Buttons Row
                Row(
                  children: [
                    // Add Today's Outfit Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCDEAB3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          elevation: 0,
                        ),
                        child: Text(
                          "Add Today's Outfit",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Next Button (outlined)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          "Next",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // * 🔹 Empty Placeholder for other tabs
  Widget _buildCostAnalysisContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sustainability Impact',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Contribution to sustainable fashion',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Item Reused',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Sustainable Materials',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Ethical Brands',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '48%',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
              UIHelper.verticalSpace(5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 60 / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColors,
                  ),
                ),
              ),
              UIHelper.verticalSpace(25.h),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item Sold',
                      style: TextFontStyle
                          .textStyle14w500SecondaryColorJosefinSans
                          .copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item Sold',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Value: \$320',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Overview Screen Data
  Widget _buildOverviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsBox(),
        UIHelper.verticalSpaceMedium,
        _buildChartBox("Categories"),
        UIHelper.verticalSpaceMedium,
        _buildChartBox("Color Distribution"),
        UIHelper.verticalSpaceMedium,
        _buildChartBox("Seasonal"),
        UIHelper.verticalSpaceMedium,
        _buildChartBox("Style"),
      ],
    );
  }

  // 🔹 Reusable Stats Overview Box
  Widget _buildStatsBox() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        border: Border.all(color: Colors.grey.shade100, width: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBlock("Total Items", "125"),
                Container(
                    width: 1.w, height: 80.h, color: Colors.grey.shade300),
                _buildInfoBlock("Wardrobe Value", "\$4125"),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Container(
                height: 1.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBlock("Avg Cost Per Wear", "\$25"),
                Container(
                    width: 1.w, height: 80.h, color: Colors.grey.shade300),
                _buildInfoBlock("Utilization Rate", "32%"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Chart Box (Pie Chart + Legends)
  Widget _buildChartBox(String title) {
    final colors = const [
      Color(0xFFB0E197),
      Color(0xFFAAD5F3),
      Color(0xFFF5CBA7),
      Color(0xFFF5A8A8),
    ];

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextFontStyle.poppins10W400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            border: Border.all(color: Colors.grey.shade100, width: 0.5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 180.h,
                      width: 180.w,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius: 60,
                          startDegreeOffset: 270,
                          borderData: FlBorderData(show: false),
                          sections: List.generate(
                            colors.length,
                            (index) => PieChartSectionData(
                              color: colors[index],
                              value: 25,
                              radius: 18.r,
                              showTitle: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "9 clothes",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "in 4 categories",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem(
                            color: colors[0],
                            label: "Shirts",
                            count: "7",
                            percent: "50%"),
                        _buildLegendItem(
                            color: colors[1],
                            label: "T-Shirts",
                            count: "7",
                            percent: "20%"),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem(
                            color: colors[2],
                            label: "Sweaters",
                            count: "2",
                            percent: "14%"),
                        _buildLegendItem(
                            color: colors[3],
                            label: "Jackets",
                            count: "2",
                            percent: "14%"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Info Block Widget
  Widget _buildInfoBlock(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          SvgPicture.asset(AppIcons.itemStats),
          UIHelper.verticalSpace(10.h),
          Text(
            title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(3.h),
          Text(
            value,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.c000000,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Legend Item Widget
  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String count,
    required String percent,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        UIHelper.horizontalSpaceSmall,
        Text(
          "$label $count  $percent",
          style: TextFontStyle.textStyle20w600c000A15ColorJosefinSans.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
