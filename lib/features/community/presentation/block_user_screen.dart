import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppbar(title: 'Block Users'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                CustomTextField(
                  controller: _searchController,
                  hintText: 'Search blocked users',
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Blocked Users (3)',
                    style: TextFontStyle.inter10W600.copyWith(
                      fontSize: 12.h,
                      color: AppColor.c000000.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                ListView.builder(
                  shrinkWrap: true, // Column-এর মধ্যে ব্যবহার করার জন্য দরকার
                  physics:
                      const NeverScrollableScrollPhysics(), // parent SingleChildScrollView scroll করবে
                  itemCount: 25, // আপাতত শুধু একটাই item থাকবে
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.profile,
                                height: 40.h,
                                width: 40.w,
                              ),
                              UIHelper.horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dennis Callis',
                                    style: TextFontStyle.inter10W400.copyWith(
                                      fontSize: 14.h,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  Text(
                                    'Blocked on Oct 12, 2025',
                                    style: TextFontStyle.inter10W400.copyWith(
                                      fontSize: 10.h,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.c000000.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                'Unblock',
                                style: TextFontStyle.inter10W400.copyWith(
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.cE53935,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}