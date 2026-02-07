import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class EditCommunityPostShimmer extends StatelessWidget {
  const EditCommunityPostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UIHelper.verticalSpace(16.h),

              // -------- Main media card shimmer --------
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(12.r),
                  dashPattern: [4, 2],
                  strokeWidth: 1,
                  color: Colors.grey.shade300,
                ),
                child: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.white),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const MediaShimmer(),
                ),
              ),

              UIHelper.verticalSpace(24.h),

              // -------- Caption label --------
              Container(
                height: 16.h,
                width: 80.w,
                color: Colors.grey.shade300,
              ),
              UIHelper.verticalSpace(9.h),

              // -------- Caption textfield shimmer --------
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(12.r),
                  dashPattern: [4, 2],
                  strokeWidth: 1,
                  color: Colors.grey.shade300,
                ),
                child: Container(
                  height: 175.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Container(
                          height: 16.h,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              // -------- Tags label --------
              Container(
                height: 16.h,
                width: 50.w,
                color: Colors.grey.shade300,
              ),
              UIHelper.verticalSpace(10.h),

              // -------- Tags shimmer --------
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(
                  3,
                  (_) => Container(
                    height: 32.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              // -------- Visibility shimmer --------
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),

              UIHelper.verticalSpace(24.h),

              // -------- Button shimmer --------
              Container(
                height: 47.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(46.r),
                ),
              ),

              UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaShimmer extends StatelessWidget {
  const MediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}