import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class OutfitSuggestionScreen extends StatefulWidget {
  const OutfitSuggestionScreen({super.key});

  @override
  State<OutfitSuggestionScreen> createState() => _OutfitSuggestionScreenState();
}

class _OutfitSuggestionScreenState extends State<OutfitSuggestionScreen> {
  final List<String> items = [
    AppImages.dress, // Free Image
    AppImages.dress,
    AppImages.dress,
    AppImages.dress,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // * App Bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(AppIcons.backIcon)),
                    UIHelper.horizontalSpace(80.w),
                    Text(
                      'Outfit Suggestions',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,

                // * Subscription Card
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.04),
                      end: Alignment(1.00, 1.00),
                      colors: [
                        const Color(0xFFE4EDC9),
                        const Color(0x60E6F0EA)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0.50,
                        color: Color(0xFFC4CABA),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      Column(
                        spacing: 8,
                        children: [
                          Text(
                            'You’ve hit your free suggestion limit.',
                            style: TextStyle(
                              color: const Color(0xFF181818),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 1.24,
                              letterSpacing: -0.18,
                            ),
                          ),
                          Text(
                            'Upgrade to unlock more!',
                            style: TextStyle(
                              color: const Color(0xFF181818),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF181818),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          'Upgrade Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.30,
                            letterSpacing: -0.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpaceMedium,

                // * Gridview builder
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final isFree = index == 0; // শুধু প্রথমটা ফ্রি
                    return Stack(
                      children: [
                        // Card Container
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                items[index],
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),

                        // Pro Tag

                        // Locked Overlay
                        if (!isFree)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.white.withOpacity(0.4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 20,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Upgrade Pro",
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.cD5E7B0,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.star,
                                  height: 14,
                                  width: 14,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Pro",
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                UIHelper.verticalSpaceMedium,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColor.cD5E7B0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: Text(
                                  '3 May 2025',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Divider(
                          color: Colors.black,
                          thickness: 0.1,
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Occasion',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColor.cD5E7B0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'Work',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Divider(
                          color: Colors.black,
                          thickness: 0.1,
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Clothes to include',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColor.cF5F5F5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'Add',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                CustomButton(
                  name: 'Refresh',
                  onCallBack: () {},
                  context: context,
                  color: AppColor.cD5E7B0,
                  borderColor: AppColor.cD5E7B0,
                  borderRadius: 30,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
