// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
// import 'package:twwillustration/features/chat/widget/date_formater.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';

// class ChatListWidget extends StatelessWidget {
//   final VoidCallback onTap;
//   final String avatar;
//   final String name;
//   final String messege;
//   final int unReadMessage;
//   final String time;

//   const ChatListWidget(
//       {super.key,
//       required this.onTap,
//       required this.avatar,
//       required this.name,
//       required this.messege,
//       required this.unReadMessage,
//       required this.time});

//   @override
//   Widget build(BuildContext context) {

//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.translucent,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//         margin: EdgeInsets.only(bottom: 8.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ShimmerClipOvalWidget(
//               height: 50.w,
//               weight: 50.w,
//               networkImageLink: avatar,
//             ),
//             UIHelper.horizontalSpaceSmall,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: TextFontStyle.inter10W600.copyWith(color: AppColor.c000000, fontSize: 16.sp),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     messege,
//                     style: TextFontStyle.inter10W400.copyWith(color: AppColor.c637381, fontSize: 14.sp),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 ],
//               ),
//             ),
//             UIHelper.horizontalSpaceSmall,
//             Column(
//               children: [
//                 unReadMessage == 0
//                     ? SizedBox.shrink()
//                     : Container(
//                         padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.r),
//                           color: AppColor.primaryColors,
//                         ),
//                         child: Center(
//                           child: Text(
//                             unReadMessage > 99 ? '99+' : unReadMessage.toString(),
//                             style: TextFontStyle.inter10W600.copyWith(color: AppColor.c000000),
//                           ),
//                         ),
//                       ),
//                 UIHelper.verticalSpace(8.h),
//                 Text(
//                   DateFormatter.formatChatTime(time),
//                   style: TextFontStyle.inter10W400.copyWith(
//                     color: AppColor.c637381,
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/chat/widget/date_formater.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ChatListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String avatar;
  final String name;
  final String messege;
  final int unReadMessage;
  final String time;
  final bool hasImage; // Add this parameter

  const ChatListWidget({
    super.key,
    required this.onTap,
    required this.avatar,
    required this.name,
    required this.messege,
    required this.unReadMessage,
    required this.time,
    this.hasImage = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    // Determine what to display in message preview
    String displayMessage = messege;
    Widget? messagePrefix;
    
    if (hasImage) {
      if (messege.isEmpty) {
        displayMessage = 'Photo';
      } else {
        // Show icon with text
        messagePrefix = Icon(
          Icons.image,
          size: 16.sp,
          color: AppColor.c637381,
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        margin: EdgeInsets.only(bottom: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerClipOvalWidget(
              height: 50.w,
              weight: 50.w,
              networkImageLink: avatar,
            ),
            UIHelper.horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextFontStyle.inter10W600.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      if (messagePrefix != null) ...[
                        messagePrefix,
                        SizedBox(width: 4.w),
                      ],
                      Expanded(
                        child: Text(
                          displayMessage,
                          style: TextFontStyle.inter10W400.copyWith(
                            color: AppColor.c637381,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              children: [
                unReadMessage == 0
                    ? const SizedBox.shrink()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: AppColor.primaryColors,
                        ),
                        child: Center(
                          child: Text(
                            unReadMessage > 99 ? '99+' : unReadMessage.toString(),
                            style: TextFontStyle.inter10W600.copyWith(
                              color: AppColor.c000000,
                            ),
                          ),
                        ),
                      ),
                UIHelper.verticalSpace(8.h),
                Text(
                  DateFormatter.formatChatTime(time),
                  style: TextFontStyle.inter10W400.copyWith(
                    color: AppColor.c637381,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}