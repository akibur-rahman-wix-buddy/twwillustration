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


Widget productCardShimmer({double width = 163, double height = 200}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.6, // image height
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 15,
          width: width * 0.6,
          color: Colors.white,
        ),
        SizedBox(height: 5),
        Container(
          height: 12,
          width: width * 0.4,
          color: Colors.white,
        ),
        SizedBox(height: 5),
        Container(
          height: 15,
          width: width * 0.5,
          color: Colors.white,
        ),
      ],
    ),
  );
}

/// Horizontal ListView Shimmer
Widget productListShimmer({int itemCount = 5}) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          width: 163,
          margin: EdgeInsets.only(right: 10),
          child: productCardShimmer(),
        );
      },
    ),
  );
}

/// GridView Shimmer
Widget productGridShimmer({int itemCount = 6}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: itemCount,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.75,
    ),
    itemBuilder: (context, index) {
      return productCardShimmer();
    },
  );
}

Widget recentSearchChipsShimmer({int itemCount = 6}) {
  return SizedBox(
    height: 30.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 30.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    ),
  );
}
/// Combined shimmer for SearchScreen
Widget searchScreenShimmer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Search TextField shimmer
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      SizedBox(height: 10.h),
      // Recent search shimmer
      recentSearchChipsShimmer(),
      SizedBox(height: 16.h),
      // Popular products shimmer
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Text(
          'Popular Products',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade400),
        ),
      ),
      SizedBox(height: 16.h),
      productListShimmer(),
    ],
  );
}
