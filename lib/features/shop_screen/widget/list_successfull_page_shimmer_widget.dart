import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class MarketplaceSuccessShimmer extends StatelessWidget {
  const MarketplaceSuccessShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔹 Success Card Shimmer
        _shimmerContainer(
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circle(size: 60),
              UIHelper.verticalSpace(16.h),
              _line(width: 220, height: 16),
              UIHelper.verticalSpace(8.h),
              _line(width: 260, height: 12),
            ],
          ),
        ),

        UIHelper.verticalSpace(24.h),

        /// 🔹 Product Card Shimmer
        _shimmerContainer(
          height: 110.h,
          child: Row(
            children: [
              _box(width: 93, height: 93),
              UIHelper.horizontalSpace(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _line(width: double.infinity, height: 14),
                    _line(width: 90, height: 22, radius: 20),
                    _line(width: 60, height: 14),
                  ],
                ),
              ),
            ],
          ),
        ),

        UIHelper.verticalSpace(20.h),

        /// 🔹 Button Shimmer
        _shimmerContainer(
          height: 52.h,
          radius: 25,
        ),

        UIHelper.verticalSpace(16.h),

        _shimmerContainer(
          height: 52.h,
          radius: 25,
        ),
      ],
    );
  }

  /// 🔹 Helpers
  Widget _shimmerContainer({
    required double height,
    Widget? child,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColor.cF3F5F7,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: double.infinity,
        height: height,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }

  Widget _line({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return Container(
      width: width == double.infinity ? double.infinity : width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _box({
    required double width,
    required double height,
  }) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _circle({required double size}) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
