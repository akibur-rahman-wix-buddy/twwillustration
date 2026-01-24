import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class CustomCategorySelectWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String title;

  const CustomCategorySelectWidget({super.key, required this.onTap, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 56.h,
            width: 56.w,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
