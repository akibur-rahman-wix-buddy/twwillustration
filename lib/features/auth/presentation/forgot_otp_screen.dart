import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/features/auth/widget/otp_verify_dialogue.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';

import '../../../assets_helper/app_fonts.dart';
import '../../../common_widgets/customized_button.dart';
import '../../../helpers/ui_helpers.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIHelper.verticalSpace(98.h),

            Text(
              "Verification",
              style: TextFontStyle.Inter10W700.copyWith(
                  fontSize: 32,
                  color: AppColor.c2F2F2F),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              "We have sent verification code to\n your email Alexandra@gmail.com",
              style: TextFontStyle.Inter10W400.copyWith(
                  fontSize: 16,
                  color: AppColor.c757575),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "Enter verification code",
              style: TextFontStyle.Inter10W400.copyWith(
                  fontSize: 16,
                  color: AppColor.c181818),
            ),
            UIHelper.verticalSpace(16.h),
            PinCodeTextField(
              length: 4,
              animationType: AnimationType.fade,
              controller: otpController,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(30),
                fieldHeight: 62,
                fieldWidth: 62,
                inactiveFillColor: AppColor.cFFFFFF,
                borderWidth: 1,
                errorBorderColor: AppColor.blackColor,
                inactiveColor:
                AppColor.blackColor.withOpacity(0.1),
                selectedColor: AppColor.blackColor.withOpacity(0.1),
                selectedBorderWidth: 1,
                activeBorderWidth: 1,
                activeFillColor: AppColor.cFFFFFF,
                activeColor: AppColor.cD5E7B0,
                selectedFillColor: AppColor.cFFFFFF,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              appContext: context,
              onCompleted: (otp) {

              },
            ),
            UIHelper.verticalSpace(16.h),
            GestureDetector(
              onTap: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Get the code?",
                    style: TextFontStyle.Inter10W400.copyWith(
                        fontSize: 16, color: const Color(0xff5A5C5F)),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    "Resend",
                    style: TextFontStyle.Inter10W600.copyWith(
                        fontSize: 16, color: const Color(0xff5A5C5F)),
                  ),
                ],
              ),
            ),


            Expanded(child: SizedBox()),
            CustomizedButton(
              text: "Continue",
              onTap: () {
                showVerificationSuccessDialog(context, onTap: () {NavigationService.navigateTo(Routes.resetPassScreen);  });
                print("============================== ${otpController.text}");
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
