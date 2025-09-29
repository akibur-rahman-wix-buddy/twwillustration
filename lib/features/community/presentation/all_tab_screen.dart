// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

/// demo content pages (replace with your real widgets)
class AllTabScreen extends StatefulWidget {
  const AllTabScreen({super.key});

  @override
  State<AllTabScreen> createState() => _AllTabScreenState();
}

class _AllTabScreenState extends State<AllTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.profile,
                                height: 32.h,
                                width: 32.w,
                              ),
                              UIHelper.horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Katis Sims",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.blackColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Jun 12, 2025 1:48 am",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          UIHelper.horizontalSpace(10.w),
                          Row(
                            children: [
                              Container(
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: AppColor.cD5E7B0,
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Follow",
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        color: AppColor.c000000,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpace(10.w),
                              Image.asset(
                                AppImages.threeDotImages,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Image.asset(AppImages.bagImages),
                      UIHelper.verticalSpace(15.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Streetwear on point',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.blackColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            Text(
                              '#streetwear #casual',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c247E00,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.cF3F5F7,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppIcons.loveIcon),
                                        UIHelper.horizontalSpace(5.w),
                                        Text(
                                          '24',
                                          style: TextFontStyle
                                              .textStyle12w400NunitoSans
                                              .copyWith(
                                            color: AppColor.blackColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpace(10.w),
                              GestureDetector(
                                onTap: () {
                                  CommentBottomSheet.show(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.cF3F5F7,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppIcons.chatsIcon),
                                        UIHelper.horizontalSpace(5.w),
                                        Text(
                                          '24',
                                          style: TextFontStyle
                                              .textStyle12w400NunitoSans
                                              .copyWith(
                                            color: AppColor.blackColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          UIHelper.horizontalSpace(10.w),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.cF3F5F7,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppIcons.sendsIcon),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CommentBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const CommentSheetContent();
      },
    );
  }
}

class CommentSheetContent extends StatelessWidget {
  const CommentSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Comments (2)",
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColor.blackColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            const Divider(height: 1),

            // Comments list
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/women/44.jpg"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sarah Johnson",
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "2h ago",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Like",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Reply",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Add comment field
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        height: 40.h,
                        hintText: "Add a comment...",
                        controller: TextEditingController(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.cD5E7B0,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          AppIcons.sendsIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
