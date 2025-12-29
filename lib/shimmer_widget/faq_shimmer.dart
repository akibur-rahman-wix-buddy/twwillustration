import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class FaqShimmer extends StatelessWidget {
  const FaqShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // ✅ shimmer items count
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.sp),
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(28.r),
            color: Colors.white,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.w,
                      height: 14.h,
                      color: Colors.white,
                    ),
                    Container(
                      width: 20.w,
                      height: 20.h,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Answer placeholder
                Container(
                  width: double.infinity,
                  height: 12.h,
                  color: Colors.white,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 180.w,
                  height: 12.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
