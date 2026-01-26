import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ProfileWidgets extends StatefulWidget {
  final SvgPicture icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? notificationSwitch;
  const ProfileWidgets({
    super.key,
    required this.icon,
    required this.title,
    this.onTap, 
    this.notificationSwitch, 
  });

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          widget.icon,
          UIHelper.horizontalSpace(12.w),
          Text(
            widget.title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 16.sp,
              color: AppColor.c5A5C5F,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
         widget.notificationSwitch ?? SvgPicture.asset(AppIcons.nextArrow),
        ],
      ),
    );
  }
}