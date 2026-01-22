import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class CommunityProfileScreen extends StatefulWidget {
  const CommunityProfileScreen({super.key});

  @override
  State<CommunityProfileScreen> createState() => _CommunityProfileScreenState();
}

class _CommunityProfileScreenState extends State<CommunityProfileScreen> {
  int selectedIndex = 0;
  int selectedCategoryIndex = 0;
  int selectedOutfitCategoryIndex = 0;
  final double value = 0.5;

  final List<String> _categories = ['Shirt', 'Bottom', 'Shoes', 'Others'];
  final List<String> outfitcategories = ['All', 'Casual', 'Work', 'Formal', 'Sport'];

  final Map<String, List<ClothesItem>> clothesData = {
    'All': [
      ClothesItem(image: 'assets/outfit1.png', category: 'Shirt'),
      ClothesItem(image: 'assets/outfit2.png', category: 'Work'),
      ClothesItem(image: 'assets/outfit3.png', category: 'Formal'),
      ClothesItem(image: 'assets/outfit4.png', category: 'Shirt'),
      ClothesItem(image: 'assets/outfit5.png', category: 'Work'),
      ClothesItem(image: 'assets/outfit6.png', category: 'Sport'),
      ClothesItem(image: 'assets/outfit7.png', category: 'Shirt'),
      ClothesItem(image: 'assets/outfit8.png', category: 'Formal'),
      ClothesItem(image: 'assets/outfit9.png', category: 'Work'),
    ],
    'Shirt': [
      ClothesItem(image: 'assets/outfit1.png', category: 'Shirt'),
      ClothesItem(image: 'assets/outfit4.png', category: 'Shirt'),
      ClothesItem(image: 'assets/outfit7.png', category: 'Shirt'),
    ],
    'Bottom': [
      ClothesItem(image: 'assets/outfit2.png', category: 'Bottom'),
      ClothesItem(image: 'assets/outfit5.png', category: 'Bottom'),
      ClothesItem(image: 'assets/outfit9.png', category: 'Bottom'),
    ],
    'Shoes': [
      ClothesItem(image: 'assets/outfit3.png', category: 'Shoes'),
      ClothesItem(image: 'assets/outfit8.png', category: 'Shoes'),
    ],
    'Others': [
      ClothesItem(image: 'assets/outfit6.png', category: 'Others'),
    ],
  };

  // * outfit
  final Map<String, List<OutfitItem>> outfitData = {
    'All': [
      OutfitItem(image: 'assets/outfit1.png', category: 'Casual'),
      OutfitItem(image: 'assets/outfit2.png', category: 'Work'),
      OutfitItem(image: 'assets/outfit3.png', category: 'Formal'),
      OutfitItem(image: 'assets/outfit4.png', category: 'Casual'),
      OutfitItem(image: 'assets/outfit5.png', category: 'Work'),
      OutfitItem(image: 'assets/outfit6.png', category: 'Sport'),
      OutfitItem(image: 'assets/outfit7.png', category: 'Casual'),
      OutfitItem(image: 'assets/outfit8.png', category: 'Formal'),
      OutfitItem(image: 'assets/outfit9.png', category: 'Work'),
    ],
    'Casual': [
      OutfitItem(image: 'assets/outfit1.png', category: 'Casual'),
      OutfitItem(image: 'assets/outfit4.png', category: 'Casual'),
      OutfitItem(image: 'assets/outfit7.png', category: 'Casual'),
    ],
    'Work': [
      OutfitItem(image: 'assets/outfit2.png', category: 'Work'),
      OutfitItem(image: 'assets/outfit5.png', category: 'Work'),
      OutfitItem(image: 'assets/outfit9.png', category: 'Work'),
    ],
    'Formal': [
      OutfitItem(image: 'assets/outfit3.png', category: 'Formal'),
      OutfitItem(image: 'assets/outfit8.png', category: 'Formal'),
    ],
    'Sport': [
      OutfitItem(image: 'assets/outfit6.png', category: 'Sport'),
    ],
  };

  final List<TabItem> tabs = [
    TabItem(
      icon: SvgPicture.asset(AppIcons.clothSvg),
      label: 'Clothes',
      count: 12,
    ),
    TabItem(
      icon: SvgPicture.asset(AppIcons.outfitSvg),
      label: 'Outfits',
      count: null,
    ),
    TabItem(
      icon: SvgPicture.asset(AppIcons.treeSvg),
      label: 'Board',
      count: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: CustomAppbar(title: 'Devid Calington', actions: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(
              child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'block') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to blotk this user?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Block",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    if (value == 'report') {
                      NavigationService.navigateTo(Routes.blockUserScreen);
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                            value: 'block',
                            child: Text(
                              'Block this user',
                              style: TextFontStyle.Inter10W500.copyWith(color: Color(0xFF5E5E5E), fontSize: 14.sp),
                            )),
                        PopupMenuItem<String>(
                            value: 'report',
                            child: Text(
                              'Report this post',
                              style: TextFontStyle.Inter10W500.copyWith(color: Color(0xFF5E5E5E), fontSize: 14.sp),
                            ))
                      ])),
        ),
        SizedBox(
          width: 16.w,
        )
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16.sp,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(11.h),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF0F0F0)),
                        child: ShimmerClipOvalWidget(
                          height: 74.h,
                          weight: 74.h,
                          networkImageLink: 'https://images.pexels.com/photos/19240510/pexels-photo-19240510.jpeg',
                        ),
                      ),
                      UIHelper.verticalSpace(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '34',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Following',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 14,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ],
                          ),
                          UIHelper.horizontalSpace(32.w),
                          Container(
                            width: 1,
                            height: 48.h,
                            color: AppColor.c000000.withValues(alpha: .2),
                          ),
                          UIHelper.horizontalSpace(32.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Followers',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 14,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(25.h),
                      CustomButton(
                          name: 'Follow',
                          onCallBack: () {},
                          context: context,
                          color: AppColor.primaryColors,
                          borderRadius: 40.r,
                          minWidth: 81.w,
                          height: 36.h,
                          borderColor: AppColor.primaryColors,
                          textStyle: TextFontStyle.Inter10W800.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          )),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                // * Tab Navigation
                Container(
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: tabs.asMap().entries.map((entry) {
                      int index = entry.key;
                      TabItem tab = entry.value;
                      bool isSelected = selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 11.5.h),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColor.cFFFFFF : AppColor.cFFFFFF,
                              borderRadius: BorderRadius.circular(39.r),
                              border: Border.all(
                                color: isSelected ? AppColor.cE4EDC9 : AppColor.cFFFFFF,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                tab.icon,
                                UIHelper.horizontalSpace(4.w),
                                Text(
                                  tab.label,
                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                    color: Color(0xFF2F2F2F),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                if(isSelected && selectedIndex != 2) ...[
                                UIHelper.horizontalSpace(4.w),
                                  Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.cD5E7B0
                                  ),
                                  padding: EdgeInsets.all(3.sp),child: Center(child: 
                                Text('12', style: TextFontStyle.Inter10W500.copyWith(fontSize: 12.sp, color: Color(0xFF2F2F2F)),),),)
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // Content Area
                Container(
                  height: MediaQuery.of(context).size.height - 450,
                  child: _buildTabContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedIndex) {
      case 0:
        return _buildClothesContent();
      case 1:
        return _buildOutfitsContent();
      case 2:
        return _buildMyTreeContent();
      default:
        return Container();
    }
  }

  // * ################################################################
  // * ####################### -- Clothes -- ##########################
  // * ################################################################
  // * Clothes Tab Content
  Widget _buildClothesContent() {
    return Column(
      children: [
        _categories.isEmpty
                ? SizedBox.shrink()
                : SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _categories.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                width: 50.w,
                                margin: EdgeInsets.only(right: 8.w),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color:
                                        selectedCategoryIndex == index ? _getCategoryColor(index) : Colors.grey[200]),
                                child: Center(
                                  child: Text(
                                    'All',
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      color: (selectedCategoryIndex == index) ? Colors.black87 : Colors.grey[600],
                                      fontWeight: (selectedCategoryIndex == index) ? FontWeight.w600 : FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          final button = _categories[index - 1];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedCategoryIndex == index ? _getCategoryColor(index) : Colors.grey[200],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                button,
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  color: (selectedCategoryIndex == index) ? Colors.black87 : Colors.grey[600],
                                  fontWeight: (selectedCategoryIndex == index) ? FontWeight.w600 : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
        UIHelper.verticalSpace(24.h),
    
        // * Clothes Grid
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: clothesData[_categories[selectedCategoryIndex]]?.length ?? 0,
            itemBuilder: (context, index) {
              final item = clothesData[_categories[selectedCategoryIndex]]![index];
              return _buildClothesCard(item);
            },
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Color(0xFFB8E6B8), // All - Light Green
      Color(0xFFF5E6A3), // Casual - Light Yellow
      Color(0xFFFFB3B3), // Work - Light Orange
      Color(0xFFFFB3D9), // Formal - Light Pink
      Color(0xFFB3D9FF), // Sport - Light Blue
    ];
    return colors[index % colors.length];
  }

  Widget _buildClothesCard(ClothesItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                          Routes.closetDetailsScreen,
                        );
                      },
                      child: Image.asset(
                        AppImages.fullDress,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // * ################################################################
  // * ####################### -- outfit -- ###########################
  // * ################################################################
  Widget _buildOutfitsContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: outfitcategories.asMap().entries.map((entry) {
                  int index = entry.key;
                  String category = entry.value;
                  bool isSelected = selectedOutfitCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOutfitCategoryIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? _getOutfitCategoryColor(index) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        category,
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          color: isSelected ? Colors.black87 : Colors.grey[600],
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // * Out Fit Clothes Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: outfitData[outfitcategories[selectedOutfitCategoryIndex]]?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = outfitData[outfitcategories[selectedOutfitCategoryIndex]]![index];
                  return _buildOutfitCard(item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOutfitCategoryColor(int index) {
    final colors = [
      Color(0xFFB8E6B8), // All - Light Green
      Color(0xFFF5E6A3), // Casual - Light Yellow
      Color(0xFFFFB3B3), // Work - Light Orange
      Color(0xFFFFB3D9), // Formal - Light Pink
      Color(0xFFB3D9FF), // Sport - Light Blue
    ];
    return colors[index % colors.length];
  }

  Widget _buildOutfitCard(OutfitItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.fullDress,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // * ################################################################
  // * ################### -- My Tree -- ##############################
  // * ################################################################
  Widget _buildMyTreeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.treeSvg,
                height: 24,
              ),
              UIHelper.horizontalSpaceSmall,
              Text(
                'My Tree Progress',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(10.h),
          Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.treeImage,
                    height: 80.h,
                    width: 80.w,
                  ),
                  UIHelper.verticalSpace(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.waterDropsSvg),
                        Text(
                          "Water Drops:",
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "120/300",
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 16,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.cC4CABA,
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      name: 'Water the Tree',
                      onCallBack: () {},
                      context: context,
                      minWidth: double.infinity,
                      color: AppColor.cD5E7B0,
                      borderColor: AppColor.cD5E7B0,
                      textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem {
  final SvgPicture icon;
  final String label;
  final int? count;

  TabItem({
    required this.icon,
    required this.label,
    this.count,
  });
}

class ClothesItem {
  final String image;
  final String category;

  ClothesItem({
    required this.image,
    required this.category,
  });
}

class OutfitItem {
  final String image;
  final String category;

  OutfitItem({
    required this.image,
    required this.category,
  });
}
