import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 60.h,
        horizontal: 20.w,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar row: avatar + texts + bell icon
            Row(
              children: [
                _circle(40.h, 40.w),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rect(width: 140.w, height: 18.h, radius: 6),
                    SizedBox(height: 8.h),
                    _rect(width: 170.w, height: 12.h, radius: 6),
                  ],
                ),
                const Spacer(),
                _rect(width: 24.w, height: 24.w, radius: 6),
              ],
            ),

            SizedBox(height: 30.h),

            // Weather card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rect(width: 160.w, height: 20.h, radius: 8),
                            SizedBox(height: 8.h),
                            _rect(width: 120.w, height: 14.h, radius: 8),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          _rect(width: 24.w, height: 24.w, radius: 6),
                          SizedBox(width: 8.w),
                          _rect(width: 60.w, height: 20.h, radius: 8),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Outfit ideas header + generate pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _rect(width: 180.w, height: 22.h, radius: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _rect(width: 80.w, height: 18.h, radius: 8),
                  ),
                )
              ],
            ),

            SizedBox(height: 20.h),

            // Filter chip row: 4 chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _chip(width: 60.w),
                _chip(width: 100.w),
                _chip(width: 90.w),
                _chip(width: 90.w),
              ],
            ),

            SizedBox(height: 25.h),

            // Two feature cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _featureCard(width: 160.w, height: 220.h),
                _featureCard(width: 160.w, height: 220.h),
              ],
            ),

            SizedBox(height: 25.h),

            // Outfit Diary header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _rect(width: 140.w, height: 22.h, radius: 8),
                _rect(width: 80.w, height: 18.h, radius: 8),
              ],
            ),

            SizedBox(height: 20.h),

            // Horizontal diary list
            SizedBox(
              height: 220.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Column(
                      children: [
                        Container(
                          width: 106.w,
                          height: 191.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _rect(width: 70.w, height: 12.h, radius: 6),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rect({required double width, required double height, double radius = 12}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circle(double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _chip({required double width}) {
    return Container(
      width: width,
      height: 36.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black.withValues(alpha:0.06)),
      ),
    );
  }

  Widget _featureCard({required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black.withValues(alpha:0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _rect(width: 24.w, height: 24.w, radius: 6),
              SizedBox(width: 8.w),
              _rect(width: 100.w, height: 16.h, radius: 6),
            ]),
            SizedBox(height: 16.h),
            _rect(width: width - 32.w, height: 14.h, radius: 6),
            SizedBox(height: 8.h),
            _rect(width: width - 64.w, height: 14.h, radius: 6),
            const Spacer(),
            _rect(width: width - 32.w, height: 40.h, radius: 24),
          ],
        ),
      ),
    );
  }
}
