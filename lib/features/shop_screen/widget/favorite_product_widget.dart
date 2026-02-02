import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class FavoriteProductWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String title;
  final dynamic price;
  final VoidCallback toggleFavorite;
  final String condation;

  const FavoriteProductWidget(
      {super.key,
      required this.imagePath,
      required this.onTap,
      required this.title,
      this.price,
      required this.toggleFavorite,
      required this.condation,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(width: 1, color: AppColor.c979CA8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerImage(
              imageUrl: imagePath,
              placeholder: AppImages.placeholderImage,
              height: 78.h,
              width: 92.w,
              boxFit: BoxFit.contain,
            ),
            UIHelper.horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextFontStyle.inter10W400.copyWith(fontSize: 14.sp, color: AppColor.c2F2F2F),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    '\$$price',
                    style: TextFontStyle.inter10W600.copyWith(fontSize: 14.sp, color: AppColor.c2F2F2F),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(Icons.favorite, color: Colors.redAccent)
                ),
                UIHelper.verticalSpaceSmall,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r), border: Border.all(width: 1, color: AppColor.c979CA8)),
                  child: Text(
                    condation,
                    style: TextFontStyle.inter10W400.copyWith(fontSize: 12.sp, color: AppColor.c757575),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
