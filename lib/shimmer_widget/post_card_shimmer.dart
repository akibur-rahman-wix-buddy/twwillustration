import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // ✅ shimmer items count
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12.h,
                            width: 100.w,
                            color: Colors.white,
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            height: 10.h,
                            width: 80.w,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Description placeholder
                  Container(
                    height: 12.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 12.h,
                    width: 200.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.h),
                  // Image placeholder
                  Container(
                    height: 191.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15.h),
                  // Title + tag placeholder
                  Row(
                    children: [
                      Container(
                        height: 12.h,
                        width: 100.w,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 12.h,
                        width: 60.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Action buttons placeholder
                  Row(
                    children: [
                      Container(
                        height: 30.h,
                        width: 80.w,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 30.h,
                        width: 80.w,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Container(
                        height: 30.h,
                        width: 60.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
