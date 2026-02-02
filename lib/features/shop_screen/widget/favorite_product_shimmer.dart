import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';

class WishlistShimmerItem extends StatelessWidget {
  const WishlistShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h, 
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                height: 70.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: 120.w,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: 80.w,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
