import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart'; 
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class EarnDropScreen extends StatefulWidget {
  const EarnDropScreen({super.key});

  @override
  State<EarnDropScreen> createState() => _EarnDropScreenState();
}

class _EarnDropScreenState extends State<EarnDropScreen> {
  final double value = 0.5;
  // Track the selected item index (null if nothing is selected)
  int? _selectedIndex;

  // Function to show the bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: AppColor.cFFFFFF,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.doneMark,
                height: 80.h,
                width: 80.w,
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Denim Jacket added!',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c000000,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.cF4F4F4,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.dropWater),
                          UIHelper.horizontalSpace(10.h),
                          Text(
                            '+1 Water Drop earned!',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.c000000,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tree Progress',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '125/300',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.c000000,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(10.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: value,
                          minHeight: 10.h,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.cC4CABA,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '3 drops to reach weekly goal',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.c000000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                _selectedIndex != null
                    ? 'You selected Logged outfit ${_selectedIndex! + 1}'
                    : 'No outfit selected',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.c000000,
                ),
              ),
              UIHelper.verticalSpace(20.h),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  name: 'Got it',
                  onCallBack: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  context: context,
                  borderRadius: 25.r,
                  borderColor: AppColor.cD5E7B0,
                  color: AppColor.cD5E7B0,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    color: AppColor.c000000,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(
        title: 'Earn Drop',
        backgroundColor: AppColor.bgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Fixed Weekly Earned Drop Container
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Weekly Earned Drop',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '125/300',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.c000000,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 10.h,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.cC4CABA,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '3 drops to reach weekly goal',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 13.sp,
                              color: AppColor.c000000,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Scrollable ListView.builder
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle selection: select if not selected, deselect if already selected
                              _selectedIndex =
                                  (_selectedIndex == index) ? null : index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.cFFFFFF,
                              borderRadius: BorderRadius.circular(12),
                              border: _selectedIndex == index
                                  ? Border.all(
                                      color: AppColor.cD5E7B0,
                                      width: 2.w,
                                    )
                                  : null,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.blueWater,
                                      ),
                                      UIHelper.horizontalSpace(12.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Logged outfit ${index + 1}',
                                            style: TextFontStyle
                                                .textStyle12w400NunitoSans
                                                .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.c000000,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.waterDrops,
                                          height: 15.h,
                                          width: 15.w,
                                        ),
                                        Text(
                                          '  + 1',
                                          style: TextFontStyle
                                              .textStyle12w400NunitoSans
                                              .copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.c000000,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Fixed Bottom Button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomButton(
                    name: 'Continue',
                    onCallBack: () {
                      // Print the selected item ID
                      debugPrint(_selectedIndex != null
                          ? 'Selected Item ID: $_selectedIndex'
                          : 'No item selected');
                      // Show toast
                      ToastUtil.showShortToast(_selectedIndex != null
                          ? 'Selected Item ID: $_selectedIndex'
                          : 'No item selected');
                      // Show bottom sheet
                      _showBottomSheet(context);
                    },
                    context: context,
                    borderRadius: 25.r,
                    borderColor: AppColor.cD5E7B0,
                    color: AppColor.cD5E7B0,
                    textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
