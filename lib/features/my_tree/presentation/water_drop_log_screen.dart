import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class WaterDropLogScreen extends StatefulWidget {
  const WaterDropLogScreen({super.key});

  @override
  State<WaterDropLogScreen> createState() => _WaterDropLogScreenState();
}

class _WaterDropLogScreenState extends State<WaterDropLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(
        title: 'Water Drop log',
        backgroundColor: AppColor.bgColor,
      ),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              AppIcons.dropWater,
                            ),
                            UIHelper.verticalSpace(8.h),
                            Text(
                              'This Week',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                            Text(
                              '125',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: AppColor.c000000,
                          thickness: 1.h,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              AppIcons.dropWater,
                            ),
                            UIHelper.verticalSpace(8.h),
                            Text(
                              'Life Time',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                            UIHelper.verticalSpace(8.h),
                            Text(
                              '187',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.blueWater,
                            ),
                            UIHelper.horizontalSpace(12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Logged outfit',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.c000000,
                                  ),
                                ),
                                Text(
                                  'Jun 28',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.cD5E7B0,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              '+ 1',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
