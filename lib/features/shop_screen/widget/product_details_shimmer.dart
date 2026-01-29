import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image slider shimmer
          _shimmerBox(height: 300.h, radius: 12),

          SizedBox(height: 20.h),

          /// Details card shimmer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 18.h, width: 180.w),
                SizedBox(height: 8.h),
                _shimmerBox(height: 18.h, width: 120.w),

                SizedBox(height: 12.h),
                _shimmerBox(height: 14.h, width: 100.w),

                SizedBox(height: 16.h),
                _shimmerBox(height: 14.h),
                SizedBox(height: 6.h),
                _shimmerBox(height: 14.h),
                SizedBox(height: 6.h),
                _shimmerBox(height: 14.h, width: 220.w),

                SizedBox(height: 16.h),
                _shimmerBox(height: 32.h, width: 80.w, radius: 20),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _shimmerBox(height: 48.h, width: 120.w, radius: 30),
                    _shimmerBox(height: 48.h, width: 120.w, radius: 30),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          /// Q&A shimmer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(height: 14.h, width: 220.w),
                      SizedBox(height: 6.h),
                      _shimmerBox(height: 14.h, width: 180.w),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// Similar items title
          _shimmerBox(height: 18.h, width: 200.w),

          SizedBox(height: 16.h),

          /// Similar items grid shimmer
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _shimmerBox(
                height: 200.h,
                radius: 12,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    double height = 16,
    double? width,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
