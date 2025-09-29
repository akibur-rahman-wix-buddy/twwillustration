// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';

/// demo content pages (replace with your real widgets)
class TrendingTabScreen extends StatelessWidget {
  // final String title;
  const TrendingTabScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Trending Page',
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
