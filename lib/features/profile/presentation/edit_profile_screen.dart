import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                      'Edit Profile',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),

                // * Profile Picture
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AppImages.profile,
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            // Add profile picture functionality
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // * Input Field All
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    child: Text(
                      'Bio',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter your bio',
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    child: Text(
                      'First Name',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter your First Name',
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    child: Text(
                      'Email',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter your Email',
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    child: Text(
                      'Location',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Enter your Location',
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    child: Text(
                      'Password',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Password',
                ),

                UIHelper.verticalSpaceMedium,
                CustomButton(
                  name: 'Changes',
                  onCallBack: () {},
                  context: context,
                  color: AppColor.cD5E7B0,
                  borderRadius: 46.r,
                  borderColor: AppColor.cD5E7B0,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 14.sp,
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
