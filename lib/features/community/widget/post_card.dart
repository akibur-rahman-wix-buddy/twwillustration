// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

/// demo content pages (replace with your real widgets)
class PostCard extends StatefulWidget {
  final String? avatar;
  final String imagePath;
  final String name;
  final String time;
  final VoidCallback toggleFollow;
  final String descreption;
  final List? tag;
  final VoidCallback onLove;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final int likeCount;
  final int commentCount;
  final bool isLike;
  final String isFollow;

  const PostCard(
      {super.key,
      this.avatar,
      required this.name,
      required this.time,
      required this.toggleFollow,
      required this.descreption,
      this.tag,
      required this.onLove,
      required this.onComment,
      required this.onShare,
      required this.likeCount,
      required this.commentCount,
      required this.imagePath,
      required this.isLike,
      required this.isFollow});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ShimmerClipOvalWidget(
                      height: 32.h,
                      weight: 32.h,
                      networkImageLink: '',
                    ),
                    UIHelper.horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateFormat("MMM dd, yyyy h:mm a")
                              .format(DateFormat("MMM dd, yyyy HH:mm:ss").parse(widget.time)),
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.horizontalSpace(10.w),
                Row(
                  children: [
                    widget.isFollow == 'self'
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: widget.toggleFollow,
                            child: Container(
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(35.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.isFollow == 'yes' ? 'Unfollow' : "Follow",
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    UIHelper.horizontalSpace(10.w),
                    Image.asset(
                      AppImages.threeDotImages,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ],
                ),
              ],
            ),
            UIHelper.verticalSpace(10.h),
            Text(
              widget.descreption,
              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                color: AppColor.blackColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            UIHelper.verticalSpace(10.h),
            ShimmerImage(imageUrl: '', placeholder: AppImages.placeholderImage, height: 191.h, width: double.infinity),
            UIHelper.verticalSpace(15.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.tag != null ? widget.tag!.map((t) => " #$t").join("") : "",
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  color: AppColor.c247E00,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Row(
              //   children: [
              //     Text(
              //       widget.title,
              //       style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              //         color: AppColor.blackColor,
              //         fontSize: 13.sp,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //     UIHelper.horizontalSpace(10.w),
              //     Text(
              //       widget.tag != null ? widget.tag!.map((t) => "#$t").join(" ")  : "",
              //       style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              //         color: AppColor.c247E00,
              //         fontSize: 13.sp,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ],
              // ),
            ),
            UIHelper.verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onLove,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.cF3F5F7,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              widget.isLike ? SvgPicture.asset(AppIcons.loveIcon) : Icon(Icons.favorite_border),
                              UIHelper.horizontalSpace(5.w),
                              Text(
                                widget.likeCount.toString(),
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(10.w),
                    GestureDetector(
                      onTap: widget.onComment,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.cF3F5F7,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppIcons.chatsIcon),
                              UIHelper.horizontalSpace(5.w),
                              Text(
                                widget.commentCount.toString(),
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.horizontalSpace(10.w),
                GestureDetector(
                  onTap: widget.onShare,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.cF3F5F7,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.sendsIcon),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const CommentSheetContent();
      },
    );
  }
}

class CommentSheetContent extends StatelessWidget {
  const CommentSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Comments (2)",
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColor.blackColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            const Divider(height: 1),

            // Comments list
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sarah Johnson",
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "2h ago",
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Like",
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Reply",
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Add comment field
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Add a comment...",
                        controller: TextEditingController(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.cD5E7B0,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          AppIcons.sendsIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
