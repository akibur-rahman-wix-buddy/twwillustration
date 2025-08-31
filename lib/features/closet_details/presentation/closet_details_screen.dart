import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ClosetDetailsScreen extends StatefulWidget {
  const ClosetDetailsScreen({super.key});

  @override
  State<ClosetDetailsScreen> createState() => _ClosetDetailsScreenState();
}

class _ClosetDetailsScreenState extends State<ClosetDetailsScreen> {
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(AppIcons.backIcon)),
                    UIHelper.horizontalSpace(100.w),
                    Text(
                      'Casual Shirt',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.shirtImages,
                      fit: BoxFit.contain,
                      height: 180.h,
                      width: 180.w,
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // * #######################
                        // * ####### Category
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Top, Dress',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Category
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Occasion',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Work',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Brand
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Brand',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Add',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Color
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Color',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Blue, Yellow',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Material
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Material',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Cotton',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Pattern
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pattern',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Striped',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Visibility
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visibility',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Only me',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Purchase Date
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Purchased Date',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '3 May 2025',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Size
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Size',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'L',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Price
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '\$120',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Season
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Season',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Winter',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
