import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';
import '../assets_helper/app_fonts.dart';
import '../assets_helper/app_image.dart';
import '../helpers/ui_helpers.dart';
import 'custom_button.dart';

void customPopup(
  BuildContext context,
  String title,
  String buttonName,
  VoidCallback ontap,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          height: 484.h,
          padding: EdgeInsets.all(20.sp),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              SizedBox(
                  width: 233.30.w,
                  height: 230.65.h,
                  child: Image.asset(AppImages.onbrdImg3)),
              UIHelper.verticalSpace(20.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    TextFontStyle.textStyle20w600primaryColor2JosefinSans,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                buttonName,
                textAlign: TextAlign.center,
                style: TextFontStyle
                    .textStyle14w500SecondaryColorJosefinSans
                    .copyWith(
                  color: AppColor.c797979,
                ),
              ),
              UIHelper.verticalSpace(14.h),
              Center(
                child: CustomButton(
                  minWidth: double.infinity,
                  borderRadius: 12.r,
                  name: 'Go To Home',
                  color: AppColor.primaryColor2,
                  textStyle: TextFontStyle
                      .textStyle16w700primaryColor2JosefinSans
                      .copyWith(
                    color: AppColor.primaryColor,
                  ),
                  onCallBack:ontap,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
