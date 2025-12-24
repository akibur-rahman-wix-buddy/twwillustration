import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/constants/textfield_validation.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

import '../../../assets_helper/app_fonts.dart';
import '../../../common_widgets/custom_textfeild.dart';
import '../../../common_widgets/customized_button.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  child: Image.asset(
                    AppImages.back,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                Text("Forgot Password",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 14,
                      color: AppColor.c2F2F2F,
                    )),
                Container(
                  height: 24,
                  width: 24,
                  color: Colors.transparent,
                )
              ],
            ),
            UIHelper.verticalSpace(105.h),
        
            Text(
              "Forgot Password",
              style: TextFontStyle.Inter10W600.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColor.c2F2F2F),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              "We will send the OTP code to your phone number\n for security in forgetting your password",
              style: TextFontStyle.inter10W400.copyWith(
                  fontSize: 14, color: AppColor.c757575),
            ),
            UIHelper.verticalSpace(22.h),
        
            /// Email
            Text(
              "Email",
              style: TextFontStyle.Inter10W600.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.c757575,
              ),
            ),
            UIHelper.verticalSpace(12.h),
            Form(
              key: _formKey,
              child: CustomTextField(
                borderColor: const Color(0xffe8e8e8),
                hintText: "Enter your email",
                controller: emailController,
                validator: (value) => InputValidator.validateEmail(value)
                // (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Please enter an email";
                //   } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                //       .hasMatch(value)) {
                //     return "Please enter a valid email";
                //   }
                //   return null;
                // },
              ),
            ),
            Expanded(child: SizedBox()),
            CustomizedButton(
              text: "Reset Password",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // Successful validation
                  print("Form is valid");
                  NavigationService.navigateToWithArgs(Routes.otpScreen, {
                    'userEmail' : emailController.text.trim(),
                    'forgetPass' : true
                  });
                }
              },
              height: 47.h,
              width: double.infinity,
              textStyle: TextFontStyle.Inter10W600.copyWith(
                fontSize: 14,
                color: AppColor.c181818,
              ),
            ),
            UIHelper.verticalSpace(32.h),
          ],
        ),
      )),
    );
  }
}
