import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class FaqItem extends StatelessWidget{

  final String question;
  final String answerr;
  final Widget iconButton;
  final bool ans;

  const FaqItem({super.key, required this.question, required this.answerr, required this.iconButton, required this.ans});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(
        bottom: 16.h
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(28.r),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  question,
                  style: TextFontStyle.inter10W400.copyWith(
                    fontSize: 14.sp,
                    color: Color(0xFF757575)
                  ),
                ),
              ),
              iconButton 
            ],
          ),
          ans ? UIHelper.verticalSpace(16.h) : UIHelper.verticalSpace(0),
          ans ? 
          Text(
            answerr,
            style: TextFontStyle.inter10W400.copyWith(
                    fontSize: 14.sp,
                    color: Color(0xFF757575)
                  ),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}