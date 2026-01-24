// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _reportDesController = TextEditingController();

  String? _selectedReportReason;
  final List<String> _reportReason = [
    'Misleading or Incorrect Information',
    'Facke User',
    '...............',
    '*******************************',
    '#########################'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: CustomAppbar(title: 'Report'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                UIHelper.verticalSpace(24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Misleading or Incorrect Information',
                      style: TextFontStyle.textStyle14w400c333333.copyWith(color: AppColor.c757575)),
                ),
                UIHelper.verticalSpace(8.h),
                Container(
                  width: double.infinity,
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(color: AppColor.cFFFFFF, borderRadius: BorderRadius.circular(28.r), border: Border.all(width: 1, color: AppColor.cE8E8E8)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedReportReason,
                      hint: Text('Misleading or Incorrect Information',
                          style: TextFontStyle.textStyle14w400c333333.copyWith(color: AppColor.c757575)),
                      icon: Icon(Icons.expand_more),
                      style: TextFontStyle.textStyle14w400c333333.copyWith(color: AppColor.c000000),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(28.r),
                      items: _reportReason.map((season) {
                        return DropdownMenuItem(value: season, child: Text(season));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedReportReason = newValue;
                        });
                      },
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Write us more',
                    style: TextFontStyle.textStyle14w400c333333.copyWith(color: AppColor.c757575)
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextField(
                  controller: _reportDesController,
                  hintText: 'Shares claims or content that are inaccurate, exaggerated, or deceptive.',
                  height: 173.h,
                  maxline: 7,
                ),
                UIHelper.verticalSpace(32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      name: 'Cancel',
                      onCallBack: () {NavigationService.goBack;},
                      context: context,
                      minWidth: 155.w,
                      borderRadius: 46.r,
                      height: 47.h,
                      borderColor: AppColor.cFFFFFF,
                      color: AppColor.cFFFFFF,
                      textStyle: TextFontStyle.inter10W400.copyWith(
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    CustomButton(
                      name: 'Submit',
                      onCallBack: () {},
                      context: context,
                      minWidth: 155.w,
                      borderRadius: 46.r,
                      height: 47.h,
                      borderColor: AppColor.primaryColors,
                      color: AppColor.primaryColors,
                      textStyle: TextFontStyle.inter10W400.copyWith(
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
