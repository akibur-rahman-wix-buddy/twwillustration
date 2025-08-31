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

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<bool> loadingStates = List.generate(10, (index) => false);

  void _handleFollowBack(int index) async {
    setState(() {
      loadingStates[index] = true;
    });

    // ৫ সেকেন্ড অপেক্ষা করা
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      loadingStates[index] = false;
    });
  }

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
                      'Followers',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.profile,
                                height: 48.h,
                                width: 48.w,
                              ),
                              UIHelper.horizontalSpace(25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chris Glasser ${index + 1}',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '@Chris Glasser ${index + 1}',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              // লোডিং অবস্থা অনুযায়ী বাটন অথবা লোডিং দেখানো
                              loadingStates[index]
                                  ? Container(
                                      width: 130.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.cD5E7B0,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: AppColor.cD5E7B0),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              AppColor.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CustomButton(
                                      name: 'Follow Back',
                                      onCallBack: () =>
                                          _handleFollowBack(index),
                                      context: context,
                                      minWidth: 130.w,
                                      height: 40.h,
                                      color: AppColor.cD5E7B0,
                                      borderColor: AppColor.cD5E7B0,
                                      textStyle: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w900,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
