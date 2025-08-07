import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_image.dart';

void showVerificationSuccessDialog(BuildContext context, {required VoidCallback onTap}) {
  // Added {required VoidCallback onTap} as a named parameter
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Top Circle/Image/Checkmark Placeholder
              Container(
                width: 98.w,
                height: 98.h,
                child: Image.asset(AppImages.star, height: 98.h, width: 98.w,),
              ),

              const SizedBox(height: 40),

              /// Title & Subtitle
              Column(
                children: [
                  Text(
                    'Verification Success!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2F2F2F),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.32,
                      letterSpacing: -0.48,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your identity has been confirmed securely and efficiently.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF757575),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.64,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// Continue Button
              GestureDetector(
                onTap: onTap, // Now this onTap refers to the parameter
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD5E7B0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(46),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.64,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}