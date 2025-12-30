import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class OutfitDairyCard extends StatelessWidget {

  final String? imagePath;
  final String day;
  final VoidCallback onAdd;

  const OutfitDairyCard({super.key, required this.imagePath, required this.day, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: imagePath == null ? onAdd : (){},
        child: Container(
          width: 106.w,
          height: 191.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.50,
                color: Color(0xFFE8E8E8),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: imagePath != null ?
          ShimmerImage(
            imageUrl: imagePath ?? '', 
            placeholder: AppImages.placeholderImage, 
            height: 191.h, 
            width: 106.w
            ) :
          Center(
            child: Icon(Icons.add, size: 48.sp, color: Colors.black54),
          ),
        ),
      ),
      UIHelper.verticalSpace(8.h),
      Text(
        day,
        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
          color: AppColor.c000000,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ]);
  }
}
