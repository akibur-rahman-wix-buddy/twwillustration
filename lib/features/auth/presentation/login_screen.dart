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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  bool isLoading = false;
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
                    "Sign In",
                    style: TextFontStyle.Inter10W600.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.c181818),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    "Please sign in with your Greendrobe account",
                    style: TextFontStyle.inter10W400.copyWith(
                        fontSize: 14, color: AppColor.c757575),
                  ),
                  UIHelper.verticalSpace(23.h),

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
                  CustomTextField(
                    borderColor: const Color(0xffe8e8e8),
                    hintText: "Enter your email",
                    controller: emailController,
                    keybordType: TextInputType.emailAddress,
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

                  /// Password
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
                      } else {
                        // NavigationService.navigateTo(Routes.navigationScreen);
                      }
                      return null;
                    },
                  ),

                  UIHelper.verticalSpace(8.h),

                  /// Forgot password
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.forgotPassScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextFontStyle.inter10W400.copyWith(
                            fontSize: 14,
                            color: AppColor.c757575,
                          ),
                        ),
                      ],
                    ),
                  ),

                  UIHelper.verticalSpace(32.h),

                  // Submit Button
                  SizedBox(
                    height: 47.h,
                    width: double.infinity,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.c181818),
                            ),
                          )
                        : CustomizedButton(
                            text: "Sign In",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // final emailc = emailController.text.trim();
                                // final passwordc = passController.text.trim();

                                // bool isSuccess = await postSigninRX.postSigninRX(
                                //   email: emailc,
                                //   password: passwordc,
                                // );

                                // if (isSuccess) {
                                //   NavigationService.navigateTo(Routes.navigationScreen);
                                // }
                                await _onLogin();
                                // Successful validation
                                print("Form is valid");
                              } else {
                                // Errors will show below the fields`
                                print("Form is invalid");
                              }
                            },
                            height: 47.h,
                            width: double.infinity,
                            textStyle: TextFontStyle.Inter10W600.copyWith(
                                fontSize: 14, color: AppColor.c181818),
                          ),
                  ),

                  UIHelper.verticalSpace(32.h),

                  Center(
                    child: Text(
                      "Or Sign In with account",
                      style: TextFontStyle.inter10W400.copyWith(
                          fontSize: 14, color: const Color(0xff5A5C5F)),
                    ),
                  ),

                  UIHelper.verticalSpace(20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleLogo,
                          height: 40.h, width: 40.w),
                      UIHelper.horizontalSpace(12.w),
                      Image.asset(AppImages.appleLogo,
                          height: 40.h, width: 40.w),
                    ],
                  ),

                  UIHelper.verticalSpace(41.h),

                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.signUpScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextFontStyle.inter10W400.copyWith(
                              fontSize: 14, color: const Color(0xff5A5C5F)),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          "Sign Up",
                          style: TextFontStyle.Inter10W600.copyWith(
                              fontSize: 14, color: const Color(0xff5A5C5F)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    final emailc = emailController.text.trim();
    final passwordc = passController.text.trim();

    setState(() {
      isLoading = true;
    });
    try {
      bool isSuccess =
          await postSigninRX.postSigninRX(email: emailc, password: passwordc);
      if (isSuccess) {
        if (mounted) {
          setState(() {
            isLoading = false;
            NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
