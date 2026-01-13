import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

/// SETTINGS ITEM WIDGET
class SettingsWidgets extends StatelessWidget {
  final SvgPicture icons;
  final String title;
  final VoidCallback onTap;

  const SettingsWidgets({
    super.key,
    required this.icons,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
          children: [
            icons,
            UIHelper.horizontalSpace(12.w),
            Text(
              title,
              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.c5A5C5F,
              ),
            ),
          ],
        ),
    );
  }
}
