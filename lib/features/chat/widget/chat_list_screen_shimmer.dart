import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ChatListShimmer extends StatelessWidget {
  const ChatListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // ✅ 10 dummy shimmer items
      padding: EdgeInsets.all(8.w),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColor.cE8E8E8,
          highlightColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            margin: EdgeInsets.only(bottom: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar shimmer
                Container(
                  height: 50.w,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                // Name + message shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.h,
                        width: 120.w,
                        color: Colors.grey[300],
                      ),
                      UIHelper.verticalSpace(6.h),
                      Container(
                        height: 14.h,
                        width: 180.w,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                // Unread + time shimmer
                Column(
                  children: [
                    Container(
                      height: 20.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    Container(
                      height: 12.h,
                      width: 40.w,
                      color: Colors.grey[300],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
