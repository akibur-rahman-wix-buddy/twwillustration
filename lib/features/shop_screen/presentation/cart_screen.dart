import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7, // bg
      appBar: CustomAppbar(
        title: 'Cart',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Remove all',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.c000000,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AppImages.dressImage,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Summer Fashion",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Worn 12x",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "\$78.99",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Excellent",
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Totals Section
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F5F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    _RowText(label: "Subtotal", value: "\$200"),
                    SizedBox(height: 4),
                    _RowText(label: "Shipping cost", value: "\$8.00"),
                    SizedBox(height: 4),
                    _RowText(label: "Tax", value: "\$0.00"),
                    Divider(thickness: 1),
                    _RowText(label: "Total", value: "\$28.00", isBold: true),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Checkout",
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowText extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _RowText({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            color: AppColor.c000000,
          ),
        ),
        Text(
          value,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            color: AppColor.c000000,
          ),
        ),
      ],
    );
  }
}
