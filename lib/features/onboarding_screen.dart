// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import '../assets_helper/app_fonts.dart';
import '../assets_helper/app_image.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> images = [
    AppImages.onbrdImg1,
    AppImages.onbrdImg2,
    AppImages.onbrdImg3,
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cD5E7B0,
      body: Stack(
        children: [
          Positioned(child: 
          Container(
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r))
            ),
            
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Column(
              children: [
                UIHelper.verticalSpace(48.h),
                Row(children: [
                  Image.asset( _currentPage == 1? AppImages.pgIndicatorFill : AppImages.pgIndicator, height: 10.h, width: 10.w,),
                  UIHelper.horizontalSpace(6.w),
                  Image.asset(_currentPage == 2? AppImages.pgIndicatorFill : AppImages.pgIndicator, height: 10.h, width: 10.w,),
                  UIHelper.horizontalSpace(6.w),
                  Image.asset(_currentPage == 3? AppImages.pgIndicatorFill : AppImages.pgIndicator, height: 10.h, width: 10.w,),
                ],),
                UIHelper.verticalSpace(29.h),

                SizedBox(
                  height: 406,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        _currentPage = index + 1; // Store 1-based page number
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),

                UIHelper.verticalSpace(26.h),
                Text(
                  _currentPage == 1 ? "Your Closet, Reimagined" :
                  _currentPage == 2 ? "Step Into Smarter Styling" :
                  "Your Closet, Reimagined",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style:  TextFontStyle.Inter10W600.copyWith(fontSize: 24, color: AppColor.c2F2F2F),
                ),

                const SizedBox(height: 8),

                // Second text
                Text(
                  _currentPage == 1 ? "Digitize your wardrobe and unlock effortless\n outfit planning." :
                  _currentPage == 2 ? "Digitize your wardrobe and unlock effortless\n outfit planning." :
                  "Digitize your wardrobe and unlock effortless\n outfit planning.",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style:  TextFontStyle.Inter10W400.copyWith(fontSize: 14, color: Color(0xff757575)),
                ),
              ],
            ),),
          ),
            left: 0, right: 0, top: 0, bottom: 92.h,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 45.h,
            child: Center(
              child: ClipOval(
                child: Container(
                  height: 91.h,
                  width: 91.w,
                  color: AppColor.cD5E7B0, // change this to any color you want
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          NavigationService.navigateTo(Routes.loginScreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        elevation: 0, // Optional: set elevation
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          width: 75.w,
                          height: 75.h,
                          child: Image.asset(
                            AppImages.onbButton, // or use Image.network(...)
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    , // optional
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
