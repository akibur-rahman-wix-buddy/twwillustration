import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/features/shop_screen/widget/custom_category_select_widget.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ShopDashboardScreen extends StatefulWidget {
  const ShopDashboardScreen({super.key});

  @override
  State<ShopDashboardScreen> createState() => _ShopDashboardScreenState();
}

class _ShopDashboardScreenState extends State<ShopDashboardScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'image': AppImages.dressImage, // Replace with valid URL or asset
      'name': 'Summer Fashion',
      'condition': 'Worn 12x',
      'price': '\$78.99',
      'status': 'Good',
    },
    {
      'image': AppImages.dressImage, // Replace with valid URL or asset
      'name': 'Summer Fashion',
      'condition': 'Worn 12x',
      'price': '\$78.99',
      'status': 'Excellent',
    },
    {
      'image': AppImages.dressImage, // Replace with valid URL or asset
      'name': 'Summer Fashion',
      'condition': 'Worn 12x',
      'price': '\$78.99',
      'status': 'Good',
    },
    {
      'image': AppImages.dressImage, // Replace with valid URL or asset
      'name': 'Summer Fashion',
      'condition': 'Worn 12x',
      'price': '\$78.99',
      'status': 'Good',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 60.h,
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 90.w,
                    ),
                    Spacer(),
                    Text(
                      'Marketplace',
                      style: TextFontStyle.Inter10W700.copyWith(fontSize: 20.sp, color: AppColor.c2F2F2F),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.searchScreen);
                      },
                      child: SvgPicture.asset(
                        AppIcons.searchIcon,
                        width: 40.w,
                      ),
                    ),
                    UIHelper.horizontalSpace(10.w),
                    GestureDetector(
                      onTap: () {
                        // Navigate to AddToShopScreen
                        NavigationService.navigateTo(Routes.wishlistScreen);
                      },
                      child: SvgPicture.asset(
                        AppIcons.addIcon,
                        width: 40.w,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(17.h),
                Container(
                  height: 146.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(AppImages.marketPlaceBanner),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Timeless Fashion',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      UIHelper.verticalSpace(2.h),
                      Text(
                        'Sustainable Style',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // * Category Section
                UIHelper.verticalSpace(28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCategorySelectWidget(onTap: () {}, imagePath: AppImages.imageOne, title: 'Dresses'),
                    CustomCategorySelectWidget(onTap: () {}, imagePath: AppImages.imageTwo, title: 'Jackets'),
                    CustomCategorySelectWidget(onTap: () {}, imagePath: AppImages.imageThree, title: 'Shoes'),
                    CustomCategorySelectWidget(onTap: () {}, imagePath: AppImages.imageFour, title: 'Accessories'),
                  ],
                ),

                // * New Arrivals Section
                UIHelper.verticalSpace(27.h),
                Text(
                  'Recently Added',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                SizedBox(
                  height: 240.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 163.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: ProductCard(
                            imageUrl: products[index]['image'],
                            name: products[index]['name'],
                            condition: products[index]['condition'],
                            price: products[index]['price'],
                            status: products[index]['status'],
                            onTap: () {
                              NavigationService.navigateTo(
                                Routes.productDetailsScreen,
                              );
                            },
                          ),
                        );
                      }),
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'This Week\'s Picks',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'View All',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl: products[index]['image'],
                      name: products[index]['name'],
                      condition: products[index]['condition'],
                      price: products[index]['price'],
                      status: products[index]['status'],
                      onTap: () {},
                    );
                  },
                ),
                UIHelper.verticalSpaceMediumLarge
              ],
            ),
          ),
        ),
      ),
    );
  }
}
