import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 0; // 0 = Free, 1 = Pro+, 2 = Family+

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppbar(title: "Subscription Plans"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            _planCard(
              index: 0,
              title: "Free",
              price: "\$0",
              duration: "/month",
              features: const [
                "Unlimited Uploads",
                "1 AI Outfit/day",
                "Outfit Diary",
                "Basic Stats",
                "Outfit Diary",
              ],
              buttonText: "Get Started",
            ),
            SizedBox(height: 16.h),
            _planCard(
              index: 1,
              title: "Pro+",
              price: "\$9.99",
              duration: "/month",
              highlightLabel: "Most Popular",
              features: const [
                "Unlimited Uploads",
                "1 AI Outfit/day",
                "Outfit Diary",
                "Basic Stats",
                "Outfit Diary",
              ],
              buttonText: "Upgrade To Pro+",
            ),
            SizedBox(height: 16.h),
            _planCard(
              index: 2,
              title: "Family Pro+",
              price: "\$24.99",
              duration: "/yearly",
              features: const [
                "Get 2 months free.",
                "Unlimited Uploads",
                "Unlimited AI Outfit/day",
                "Outfit Diary",
                "Basic Stats",
                "Outfit Diary",
              ],
              buttonText: "Choose Family+",
            ),
          ],
        ),
      ),
    );
  }

  Widget _planCard({
    required int index,
    required String title,
    required String price,
    required String duration,
    required List<String> features,
    required String buttonText,
    String? highlightLabel,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColors.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColors : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColor.primaryColors.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextFontStyle.Inter10W700.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextFontStyle.Inter10W700.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      duration,
                      style: TextFontStyle.Inter10W700.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Features List
            ...features.map(
              (f) => Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 18, color: Colors.black54),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        f,
                        style: TextFontStyle.Inter10W700.copyWith(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // Selectable Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? AppColor.primaryColors // ✅ selected = green
                      : const Color(0xFFF3F4F6), // default = greyish white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: TextFontStyle.Inter10W700.copyWith(
                    color: isSelected ? Colors.black : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
