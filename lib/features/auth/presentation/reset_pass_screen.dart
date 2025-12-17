import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../assets_helper/app_colors.dart';
import '../../../assets_helper/app_fonts.dart';
import '../../../common_widgets/custom_textfeild.dart';
import '../../../common_widgets/customized_button.dart';
import '../../../helpers/ui_helpers.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {

  final TextEditingController rePassController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(25.h),
                  Text(
                    "Greendrobe",
                    style: TextFontStyle.Inter10W600.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c181818),
                  ),
                  UIHelper.verticalSpace(32.h),
                  Text(
                    "Reset Your Password",
                    style: TextFontStyle.Inter10W600.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c181818),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    "Please enter new password to reset your old password",
                    style: TextFontStyle.inter10W400.copyWith(
                        fontSize: 14, color: AppColor.c757575),
                  ),
                  UIHelper.verticalSpace(23.h),

                  /// Email
                  Text(
                    "New Password",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    fieldColor: AppColor.cFFFFFF,
                    borderColor: const Color(0xffe8e8e8),
                    height: 56.h,
                    hintText: "Enter your password",
                    controller: passController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(16.h),

                  /// Password
                  Text(
                    "Confirm Password",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    fieldColor: AppColor.cFFFFFF,
                    borderColor: const Color(0xffe8e8e8),
                    height: 56.h,
                    hintText: "Re-Enter your password",
                    controller: rePassController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      } else if(passController.text != rePassController.text) {
                        return "Password Mismatch";
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(8.h),


                  UIHelper.verticalSpace(32.h),

                  /// Submit Button
                  CustomizedButton(
                    text: "Continue",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Successful validation
                        print("Form is valid");
                      } else {
                        // Errors will show below the fields
                        print("Form is invalid");
                      }
                    },
                    height: 47.h,
                    width: double.infinity,
                    textStyle: TextFontStyle.Inter10W600.copyWith(
                        fontSize: 14, color: AppColor.c181818),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
