import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopDashboardShimmer extends StatelessWidget {
  const ShopDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header shimmer
          _shimmerBox(height: 24.h, width: 150.w),
          SizedBox(height: 20.h),

          /// Banner shimmer
          _shimmerBox(height: 146.h, width: double.infinity),
          SizedBox(height: 28.h),

          /// Category shimmer
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _shimmerBox(
                  height: 40.h,
                  width: 80.w,
                  radius: 20.r,
                ),
              ),
            ),
          ),

          SizedBox(height: 30.h),

          /// Section title
          _shimmerBox(height: 18.h, width: 120.w),
          SizedBox(height: 16.h),

          /// Horizontal product shimmer
          SizedBox(
            height: 240.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(height: 160.h, width: 160.w),
                    SizedBox(height: 8.h),
                    _shimmerBox(height: 14.h, width: 100.w),
                    SizedBox(height: 6.h),
                    _shimmerBox(height: 14.h, width: 60.w),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 30.h),

          /// Grid shimmer
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 150.h, width: double.infinity),
                SizedBox(height: 8.h),
                _shimmerBox(height: 14.h, width: 100.w),
                SizedBox(height: 6.h),
                _shimmerBox(height: 14.h, width: 60.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double height,
    required double width,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
