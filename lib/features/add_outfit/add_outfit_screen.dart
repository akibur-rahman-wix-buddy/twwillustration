import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class OutfitScreen extends StatefulWidget {
  const OutfitScreen({super.key});

  @override
  State<OutfitScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
  final List<String> tabs = ["Clothes", "Outfits", "AI"];
  String selectedTab = "Clothes";

  final List<Map<String, dynamic>> clothesCategories = [
    {"name": "All", "color": const Color(0xFFC8E6C9)},
    {"name": "Top", "color": const Color(0xFFB3E5FC)},
    {"name": "Pants", "color": const Color(0xFFFFE0B2)},
    {"name": "Jacket", "color": const Color(0xFFFFCDD2)},
    {"name": "Shoes", "color": const Color(0xFFBBDEFB)},
  ];

  final List<Map<String, dynamic>> outfitCategories = [
    {"name": "All", "color": const Color(0xFFD6E7B9)},
    {"name": "Summer", "color": const Color(0xFFFFF59D)},
    {"name": "Winter", "color": const Color(0xFFB3E5FC)},
    {"name": "Casual", "color": const Color(0xFFFFCCBC)},
    {"name": "Formal", "color": const Color(0xFFC5CAE9)},
  ];

  String selectedCategory = "All";

  final Map<String, List<String>> tabImages = {
    "Clothes": [
      AppImages.borkaImage,
      AppImages.pantImage,
      AppImages.shirtImage,
      AppImages.sunglassImage,
      AppImages.bagImages,
      AppImages.dressImage,
    ],
    "Outfits": [
      AppImages.dressImage,
      AppImages.pantImage,
      AppImages.shirtImage,
      AppImages.borkaImage,
    ],
    "AI": [
      AppImages.sunglassImage,
      AppImages.bagImages,
      AppImages.dressImage,
    ],
  };

  final Map<String, List<String>> clothesByCategory = {
    "All": [
      AppImages.borkaImage,
      AppImages.pantImage,
      AppImages.shirtImage,
      AppImages.sunglassImage,
      AppImages.bagImages,
      AppImages.dressImage,
    ],
    "Top": [AppImages.shirtImage],
    "Pants": [AppImages.pantImage],
    "Jacket": [AppImages.borkaImage],
    "Shoes": [AppImages.bagImages],
  };

  final Map<String, List<String>> outfitsByCategory = {
    "All": [
      AppImages.dressImage,
      AppImages.pantImage,
      AppImages.shirtImage,
      AppImages.borkaImage,
    ],
    "Summer": [AppImages.dressImage],
    "Winter": [AppImages.borkaImage],
    "Casual": [AppImages.shirtImage],
    "Formal": [AppImages.pantImage],
  };

  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    List<String> currentImages = [];

    if (selectedTab == "Clothes") {
      currentImages = clothesByCategory[selectedCategory] ?? [];
    } else if (selectedTab == "Outfits") {
      currentImages = outfitsByCategory[selectedCategory] ?? [];
    } else {
      currentImages = tabImages[selectedTab] ?? [];
    }

    List<Map<String, dynamic>> activeCategories =
        selectedTab == "Clothes" ? clothesCategories : outfitCategories;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(
        title: 'Select outfit',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * 🔹 Tabs + Add Icon Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      children: [
                        for (var tab in tabs)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = tab;
                                selectedCategory = "All";
                                selectedIndexes.clear();
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: selectedTab == tab
                                    ? const Color(0xFFD6E7B9)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                tab,
                                style: TextFontStyle.interSemibold.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Add button pressed!");
                    },
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                          const Icon(Icons.add, size: 22, color: Colors.black),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // * 🔹 Category Chips (for Clothes & Outfits)
              if (selectedTab == "Clothes" || selectedTab == "Outfits")
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activeCategories.map((cat) {
                      bool isSelected = cat["name"] == selectedCategory;
                      return Padding(
                        padding:
                            EdgeInsets.only(right: 5.w, bottom: 5.h, left: 5.w),
                        child: ChoiceChip(
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 3.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          elevation: isSelected ? 2 : 0,
                          shadowColor: Colors.grey.shade200,
                          label: Text(
                            cat["name"],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = cat["name"];
                              selectedIndexes.clear();
                            });
                          },
                          selectedColor: cat["color"],
                          backgroundColor: cat["color"],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              if (selectedTab == "Clothes" || selectedTab == "Outfits")
                SizedBox(height: 20.h),

              // * 🔹 Image Grid
              Expanded(
                child: GridView.builder(
                  itemCount: currentImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndexes.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade200,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  currentImages[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          // 🔹 Selection indicator
                          Positioned(
                            top: 12,
                            right: 13,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.grey.shade500,
                                ),
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 14)
                                  : const Icon(Icons.circle_outlined,
                                      color: Colors.grey, size: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColor.cFFFFFF,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.addCloth,
                        ),
                        UIHelper.verticalSpace(10.h),
                        Text('Add Cloth'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColor.cFFFFFF,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.addStickers,
                        ),
                        UIHelper.verticalSpace(10.h),
                        Text('Add Cloth'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColor.cFFFFFF,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.addBackground,
                        ),
                        UIHelper.verticalSpace(10.h),
                        Text('Add Cloth'),
                      ],
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              // * 🔹 Continue Button (updated logic)
              // CustomButton(
              //   name: 'Continue',
              //   onCallBack: () {
              //     List<String> selectedItems =
              //         selectedIndexes.map((i) => currentImages[i]).toList();

              //     debugPrint(
              //         "Selected Category: $selectedCategory\nSelected Items: $selectedItems");
              //   },
              //   context: context,
              //   color: AppColor.cD5E7B0,
              //   borderColor: AppColor.cD5E7B0,
              //   textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              //     fontSize: 16.sp,
              //     color: Colors.black,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),

              CustomButton(
                name: 'Continue',
                onCallBack: () {
                  NavigationService.navigateTo(Routes.manageOutfitScreen);
                  // List<String> selectedItems =
                  //     selectedIndexes.map((i) => currentImages[i]).toList();

                  // // 👇 "All" বাদ দিয়ে category নাম ঠিক করা হলো
                  // String categoryToPrint =
                  //     selectedCategory == "All" ? "" : selectedCategory;

                  // if (categoryToPrint.isNotEmpty) {
                  //   log("Selected Category: $categoryToPrint\nSelected Items: $selectedItems");
                  // } else {
                  //   log("Selected Items: $selectedItems");
                  // }
                },
                context: context,
                color: AppColor.cD5E7B0,
                borderColor: AppColor.cD5E7B0,
                textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
