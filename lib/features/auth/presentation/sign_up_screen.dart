import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/common_widgets/customized_button.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoadong = false;

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
                      color: AppColor.c181818,
                    ),
                  ),
                  UIHelper.verticalSpace(32.h),
                  Text(
                    "Sign Up",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.c181818,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    "Create your Greendrobe account to get started.",
                    style: TextFontStyle.inter10W400.copyWith(
                      fontSize: 14,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(23.h),

                  /// =============== First Name Field =============== ///
                  Text(
                    "First Name",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    borderColor: const Color(0xffe8e8e8),
                    hintText: "Enter your first name",
                    controller: firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// =============== Last Name Field =============== ///
                  Text(
                    "Last Name",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    borderColor: const Color(0xffe8e8e8),
                    hintText: "Enter your Last name",
                    controller: lastNameameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name";
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// =============== Email Field =============== ///
                  Text(
                    "Email",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    borderColor: const Color(0xffe8e8e8),
                    hintText: "Enter your email",
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// =============== Password Field =============== ///
                  Text(
                    "Password",
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.c757575,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  CustomTextField(
                    borderColor: const Color(0xffe8e8e8),
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
                  UIHelper.verticalSpace(8.h),

                  /// =============== Sign In Link =============== ///
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.loginScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextFontStyle.inter10W400.copyWith(
                            fontSize: 14,
                            color: const Color(0xff5A5C5F),
                          ),
                        ),
                        UIHelper.horizontalSpace(4.w),
                        Text(
                          "Sign In",
                          style: TextFontStyle.Inter10W600.copyWith(
                            fontSize: 14,
                            color: const Color(0xff5A5C5F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(32.h),

                  /// =============== Sign Up Button =============== ///
                  isLoadong
                      ? Center(child: CircularProgressIndicator())
                      : CustomizedButton(
                          text: "Sign Up",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoadong = true;
                              });
                              final firstName = firstNameController.text.trim();
                              final lastName =
                                  lastNameameController.text.trim();
                              final email = emailController.text.trim();
                              final password = passController.text;

                              try {
                                bool sucess =
                                    await postSignupRXObj.postSignupRX(
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        password: password);
                                if (sucess) {
                                  NavigationService.navigateToWithArgs(
                                      Routes.otpScreen, {
                                    "userEmail": email,
                                    "forgetPass":false,
                                  });
                                } else {
                                  throw Exception();
                                }
                              } catch (error) {
                                print('$error');
                              } finally {
                                setState(() {
                                  isLoadong = false;
                                });
                              }
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

                  /// =============== Social Login =============== ///
                  Center(
                    child: Text(
                      "Or Sign Up with account",
                      style: TextFontStyle.inter10W400.copyWith(
                        fontSize: 14,
                        color: const Color(0xff5A5C5F),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.googleLogo,
                        height: 40.h,
                        width: 40.w,
                      ),
                      UIHelper.horizontalSpace(12.w),
                      Image.asset(
                        AppImages.appleLogo,
                        height: 40.h,
                        width: 40.w,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(41.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
