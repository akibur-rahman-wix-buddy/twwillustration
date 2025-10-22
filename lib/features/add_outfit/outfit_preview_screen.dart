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

class OutfitPreviewScreen extends StatefulWidget {
  const OutfitPreviewScreen({super.key});

  @override
  State<OutfitPreviewScreen> createState() => _OutfitPreviewScreenState();
}

class _OutfitPreviewScreenState extends State<OutfitPreviewScreen> {
  final double value = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigationService.goBack();
                              },
                              child: SvgPicture.asset(
                                AppIcons.backIcon,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          AppImages.shirtBigImage,
                        ),
                        Image.asset(
                          AppImages.pantBigImage,
                        ),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  '09 Aug, 2023',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 20,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Occasion',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  'Work',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 20,
                            indent: 0, // left spacing
                            endIndent: 0 // right spacing
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visibility',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  'Private',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 20,
                            indent: 0, // left spacing
                            endIndent: 0 // right spacing
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add a diary',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cDFE3E8,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  'ADD',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 14.sp,
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
                UIHelper.verticalSpaceMedium,
                CustomButton(
                  name: 'Save outfit',
                  onCallBack: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppIcons.successIcon),
                                SizedBox(height: 16.h),
                                Text(
                                  "Denim Shirt added!",
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.c000000,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColor.c000000.withOpacity(0.1),
                                        blurRadius: 4.r,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppIcons.waterDrops,
                                                    color: AppColor.c757575,
                                                  ),
                                                  UIHelper.horizontalSpace(5.w),
                                                  Text(
                                                    ' +1 Water Drop earned!',
                                                    style: TextFontStyle
                                                        .textStyle12w400NunitoSans
                                                        .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor.c000000,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(10.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  UIHelper.horizontalSpace(5.w),
                                                  Text(
                                                    'Water Drops',
                                                    style: TextFontStyle
                                                        .textStyle12w400NunitoSans
                                                        .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor.c000000,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '125/300',
                                                style: TextFontStyle
                                                    .textStyle12w400NunitoSans
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.c000000,
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(10.h),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: LinearProgressIndicator(
                                              value: value,
                                              minHeight: 10.h,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                AppColor.cC4CABA,
                                              ),
                                            ),
                                          ),
                                          UIHelper.verticalSpace(10.h),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '3 drops to reach weekly goal',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.cADAEBC,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CustomButton(
                                  name: 'Got it',
                                  onCallBack: () {},
                                  context: context,
                                  borderColor: AppColor.cD5E7B0,
                                  color: AppColor.cD5E7B0,
                                  textStyle:
                                      TextFontStyle.interSemibold.copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  context: context,
                  borderColor: AppColor.cD5E7B0,
                  color: AppColor.cD5E7B0,
                  textStyle: TextFontStyle.interSemibold.copyWith(
                    color: AppColor.c000000,
                    fontSize: 14.sp,
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
