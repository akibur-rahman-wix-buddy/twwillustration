import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedOccasion;
  String? selectedMood;
  String? selectedColor;

  final List<String> occasions = ["Birthday", "Wedding", "Party"];
  final List<String> moods = ["Happy", "Sad", "Excited"];
  final List<String> colors = ["Red", "Green", "Blue"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                // * App Bar Part
                Row(
                  children: [
                    Image.asset(
                      AppImages.profile,
                      height: 40.h,
                      width: 40.w,
                    ),
                    UIHelper.horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Kenneth!',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColor.c000000,
                          ),
                        ),
                        Text(
                          'Dress what feels right today',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 12,
                            color: AppColor.c000000,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset(AppIcons.notification),
                  ],
                ),
                UIHelper.verticalSpace(30.h),

                // * Weather Part
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.04),
                      end: Alignment(1.00, 1.00),
                      colors: [
                        const Color(0x4C81CA17),
                        const Color(0x60E6F0EA)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 77,
                          children: [
                            Container(
                              width: 139,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  SizedBox(
                                    width: 139,
                                    child: Text(
                                      'New York City',
                                      style: TextStyle(
                                        color: const Color(0xFF2F2F2F),
                                        fontSize: 20,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.32,
                                        letterSpacing: -0.20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 139,
                                    child: Text(
                                      'Tue, May 17',
                                      style: TextStyle(
                                        color: const Color(0xFF757575),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.71,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(),
                                ),
                                SvgPicture.asset(AppIcons.farenheit),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '54',
                                        style: TextStyle(
                                          color: const Color(0xFF2F2F2F),
                                          fontSize: 20,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 1.32,
                                          letterSpacing: -0.20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'o',
                                        style: TextStyle(
                                          color: const Color(0xFF2F2F2F),
                                          fontSize: 20,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 1.32,
                                          letterSpacing: -0.20,
                                          fontFeatures: [
                                            FontFeature.enable("sups")
                                          ],
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' F',
                                        style: TextStyle(
                                          color: const Color(0xFF2F2F2F),
                                          fontSize: 20,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 1.32,
                                          letterSpacing: -0.20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(30.h),

                // * outfit ideas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OutFit Ideas for Today',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.cFFFFFF.withOpacity(0.1),
                        border: Border.all(
                          color: AppColor.c000000.withOpacity(0.1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Generate',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                UIHelper.verticalSpace(20.h),

                // * Filter Chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: const Text("All"),
                      backgroundColor: Colors.green.shade100,
                    ),

                    // * Occasion Dropdown
                    _buildDropdownChip(
                      title: "Occasion",
                      items: occasions,
                      selected: selectedOccasion,
                      onChanged: (value) {
                        setState(() => selectedOccasion = value);
                      },
                      color: Colors.orange.shade100,
                    ),

                    // * Mood Dropdown
                    _buildDropdownChip(
                      title: "Mood",
                      items: moods,
                      selected: selectedMood,
                      onChanged: (value) {
                        setState(() => selectedMood = value);
                      },
                      color: Colors.yellow.shade100,
                    ),

                    // * Color Dropdown
                    _buildDropdownChip(
                      title: "Color",
                      items: colors,
                      selected: selectedColor,
                      onChanged: (value) {
                        setState(() => selectedColor = value);
                      },
                      color: Colors.pink.shade100,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(25.h),
                // * Outfit Suggestions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 220.h, // ✅ Fix height
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.cFFFFFF,
                          border: Border.all(
                            color: AppColor.c000000.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.styleIcon),
                                  UIHelper.horizontalSpace(8.w),
                                  Text(
                                    'Style My Own',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceMedium,
                              Text(
                                  'Create your own outfit combinations with AI assistance'),
                              const Spacer(),
                              CustomButton(
                                name: 'Create Outfit',
                                onCallBack: () {},
                                context: context,
                                borderRadius: 48.r,
                                color: AppColor.cE4EDC9,
                                textStyle: TextFontStyle
                                    .textStyle12w400NunitoSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 220.h, // ✅ Same fixed height
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.cFFFFFF,
                          border: Border.all(
                            color: AppColor.c000000.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.statsIcon),
                                  UIHelper.horizontalSpace(8.w),
                                  Text(
                                    'Quick Stats',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceMedium,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '42',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          color: AppColor.c000000,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      UIHelper.verticalSpaceSmall,
                                      Text(
                                        'Items',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          color: AppColor.c000000,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '68%',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          color: AppColor.c000000,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      UIHelper.verticalSpaceSmall,
                                      Text(
                                        'Usage',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          color: AppColor.c000000,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(), // ✅ button নিচে যাবে
                              CustomButton(
                                name: 'View Details',
                                onCallBack: () {},
                                context: context,
                                borderRadius: 48.r,
                                borderColor: AppColor.c000000,
                                color: AppColor.cFFFFFF.withOpacity(0.1),
                                textStyle: TextFontStyle
                                    .textStyle12w400NunitoSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(25.h),
                // * outfit ideas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Outfit Diary',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 120,
                          height: 300,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                color: Color(0xFFE8E8E8),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.add,
                                size: 48, color: Colors.black54),
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Yesterday',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 120,
                          height: 300,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                color: Color(0xFFE8E8E8),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.add,
                                size: 48, color: Colors.black54),
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Yesterday',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 120,
                          height: 300,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                color: Color(0xFFE8E8E8),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.add,
                                size: 48, color: Colors.black54),
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Tomorrow',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownChip({
    required String title,
    required List<String> items,
    required String? selected,
    required Function(String?) onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          hint: Text(
            title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.c000000,
            ),
          ),
          icon: SvgPicture.asset(
            AppIcons.dropDown,
          ),
          onChanged: onChanged,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
