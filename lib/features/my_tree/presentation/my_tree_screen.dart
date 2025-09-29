import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class MyTreeScreen extends StatefulWidget {
  const MyTreeScreen({super.key});

  @override
  State<MyTreeScreen> createState() => _MyTreeScreenState();
}

class _MyTreeScreenState extends State<MyTreeScreen> {
  final double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(
        title: 'My Tree',
        backgroundColor: AppColor.bgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            16.sp,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Tree Screen',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.c000000,
                  ),
                ),
              ),
              UIHelper.verticalSpace(70.h),
              Image.asset(
                AppImages.treeImage,
                height: 80.h,
                width: 80.w,
              ),
              UIHelper.verticalSpace(70.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.cD5E7B0,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    'Label',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.c000000,
                    ),
                  ),
                ),
              ),
              Text(
                '25',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c000000,
                ),
              ),
              Text(
                'Water Drops',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c000000,
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.cFFFFFF,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.c000000.withOpacity(0.1),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.treeStage),
                                UIHelper.horizontalSpace(5.w),
                                Text(
                                  'Tree Stage',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Sprout',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.waterDrops),
                                UIHelper.horizontalSpace(5.w),
                                Text(
                                  'Water Drops',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '125/300',
                              style: TextFontStyle.textStyle12w400NunitoSans
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
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 10.h,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.cC4CABA,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.growth),
                                UIHelper.horizontalSpace(5.w),
                                Text(
                                  'Growth Status',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '125/300',
                              style: TextFontStyle.textStyle12w400NunitoSans
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
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 10.h,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.cC4CABA,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
              CustomButton(
                name: 'View Earning Action',
                onCallBack: () {
                  NavigationService.navigateTo(Routes.waterDropLogScreen);
                },
                context: context,
                borderRadius: 25.r,
                borderColor: AppColor.cD5E7B0,
                color: AppColor.cD5E7B0,
                textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  color: AppColor.c000000,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              CustomButton(
                name: 'Redeem Rewards',
                onCallBack: () {
                  NavigationService.navigateTo(Routes.earnDropScreen);
                },
                context: context,
                borderRadius: 25.r,
                borderColor: AppColor.cD5E7B0,
                color: AppColor.cFFFFFF,
                textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  color: AppColor.c000000,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
