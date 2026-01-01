import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ClosetDetailsShimmer extends StatelessWidget {
  const ClosetDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20.h,
            width: 150.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
    
        // Image shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        SizedBox(height: 16.h),
    
        // Category shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
    
        // Occasion shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
    
        // Color shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
    
        // Multiple lines shimmer (for description or list)
        Column(
          children: List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 16.h,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
