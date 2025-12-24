// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final _reportSourchController = TextEditingController();
  final _reportDesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppbar(title: 'Devid Calington'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Why are your reporting this post?',
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 12.h,
                      color: AppColor.c000000.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                CustomTextField(
                  controller: _reportSourchController,
                  hintText: 'Misleading or Incorrect Information',
                ),
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Write us more',
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 12.h,
                      color: AppColor.c000000.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                CustomTextField(
                  controller: _reportDesController,
                  hintText: 'Misleading or Incorrect Information',
                  maxline: 4,
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      name: 'Cancel',
                      onCallBack: () {},
                      context: context,
                      minWidth: 155.w,
                      borderRadius: 40.r,
                      height: 40.h,
                      borderColor: AppColor.cFFFFFF,
                      color: AppColor.cFFFFFF,
                      textStyle: TextFontStyle.inter10W400.copyWith(
                        color: AppColor.c000000,
                        fontSize: 12.sp,
                      ),
                    ),
                    CustomButton(
                      name: 'Submit',
                      onCallBack: () {},
                      context: context,
                      minWidth: 155.w,
                      borderRadius: 40.r,
                      height: 40.h,
                      borderColor: AppColor.primaryColors,
                      color: AppColor.primaryColors,
                      textStyle: TextFontStyle.inter10W400.copyWith(
                        color: AppColor.c000000,
                        fontSize: 12.sp,
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
