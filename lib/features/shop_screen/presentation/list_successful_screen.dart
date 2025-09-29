import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ListSuccessfulScreen extends StatefulWidget {
  const ListSuccessfulScreen({super.key});

  @override
  State<ListSuccessfulScreen> createState() => _ListSuccessfulScreenState();
}

class _ListSuccessfulScreenState extends State<ListSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: 'List Item',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.successIcon,
                        ),
                        UIHelper.verticalSpace(10.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Your vintage item has been successfully listed!",
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Your item has been successfully listed and is now visible to shoppers",
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.dressImage,
                          height: 100.h,
                        ),
                        UIHelper.horizontalSpace(10.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Summer Fashion",
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            UIHelper.verticalSpace(5.h),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cF3F5F7,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.c000000.withOpacity(0.2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Excellent",
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(5.h),
                            Text(
                              "\$24.00",
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
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
                CustomButton(
                  name: 'View Your Listing',
                  onCallBack: () {
                    Get.to(() => ListSuccessfulScreen());
                  },
                  borderRadius: 25.r,
                  context: context,
                  color: AppColor.cD5E7B0,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.blackColor,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CustomButton(
                  name: 'Share Your Listing',
                  onCallBack: () {
                    Get.to(() => ListSuccessfulScreen());
                  },
                  borderRadius: 25.r,
                  context: context,
                  color: AppColor.cFFFFFF,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.blackColor,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CustomButton(
                  name: 'List Another Item',
                  onCallBack: () {
                    Get.to(() => ListSuccessfulScreen());
                  },
                  borderRadius: 25.r,
                  context: context,
                  color: AppColor.cFFFFFF,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.blackColor,
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
