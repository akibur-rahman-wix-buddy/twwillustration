// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';

class AiSuggestionScreen extends StatefulWidget {
  const AiSuggestionScreen({super.key});

  @override
  State<AiSuggestionScreen> createState() => _AiSuggestionScreenState();
}

class _AiSuggestionScreenState extends State<AiSuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Outfit Suggestions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // --- Upgrade Banner ---
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F3E5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Text(
                    "You’ve hit your free suggestion limit.\nUpgrade to unlock more!",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.inter10W700.copyWith(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to subscription screen
                      NavigationService.navigateTo(Routes.subscriptionScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    ),
                    child: Text(
                      "Upgrade Now",
                      style: TextFontStyle.inter10W600.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Outfit Grid ---
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final bool isFree = index == 0;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: isFree
                              ? Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    AppImages.dress,
                                    height: 200.h, // replace with your image
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.8),
                                    BlendMode.srcATop,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Image.asset(
                                      height: 200.h,
                                      AppImages.dress,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // --- Overlay for Pro Locked Items ---
                      if (!isFree)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock, color: Colors.black54),
                              SizedBox(height: 6),
                              Text(
                                "Upgrade Pro",
                                style: TextFontStyle.inter10W700.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // --- Pro Badge ---
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF5E1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Pro",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // --- Form Section ---
            Container(
              height: 140.h,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Date", "3 May 2025"),
                  Divider(height: 16.h, color: Colors.grey[300]),
                  _infoRow("Occasion", "Work"),
                  Divider(height: 16.h, color: Colors.grey[300]),
                  _infoRow("Clothes to include", "Add",
                      trailingIcon: Icons.add),
                ],
              ),
            ),

            // --- Refresh Button ---
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9EAC8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  "Refresh",
                  style: TextFontStyle.inter10W700.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value, {IconData? trailingIcon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextFontStyle.inter10W700.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 14.sp,
            )),
        Row(
          children: [
            Text(
              value,
              style: TextFontStyle.inter10W700.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 5),
              Icon(trailingIcon, size: 18, color: Colors.black54),
            ]
          ],
        ),
      ],
    );
  }
}
