import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
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
                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigate to SearchScreen
                    //     NavigationService.navigateTo(Routes.searchScreen);
                    //   },
                    //   child: SvgPicture.asset(
                    //     AppIcons.backIcon,
                    //     height: 40.h,
                    //     width: 40.w,
                    //   ),
                    // ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigate to SearchScreen
                        NavigationService.navigateTo(Routes.searchScreen);
                      },
                      child: SvgPicture.asset(
                        AppIcons.searchIcon,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                    UIHelper.horizontalSpace(10.w),
                    GestureDetector(
                      onTap: () {
                        // Navigate to AddToShopScreen
                        NavigationService.navigateTo(Routes.addToShop);
                      },
                      child: SvgPicture.asset(
                        AppIcons.addIcon,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  height: 150.h,
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
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black87,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(2.h),
                      Text(
                        'Sustainable Style',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black87,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // * Category Section
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imageOne,
                          height: 56.h,
                          width: 56.w,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Dresses',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imageTwo,
                          height: 56.h,
                          width: 56.w,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Jackets',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imageThree,
                          height: 56.h,
                          width: 56.w,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Shoes',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imageFour,
                          height: 56.h,
                          width: 56.w,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Accessories',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // * New Arrivals Section
                UIHelper.verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'This Week\'s Picks',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            150.h -
                            24.h -
                            56.h -
                            24.h -
                            24.h)
                        .clamp(200.h,
                            double.infinity), // Adjusted height calculation
                    child: GridView.builder(
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
                        return GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.productDetailsScreen,
                            );
                          },
                          child: ProductCard(
                            imageUrl: products[index]['image'],
                            name: products[index]['name'],
                            condition: products[index]['condition'],
                            price: products[index]['price'],
                            status: products[index]['status'],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // * Recently Viewed Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently Added',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            150.h -
                            24.h -
                            56.h -
                            24.h -
                            24.h)
                        .clamp(200.h,
                            double.infinity), // Adjusted height calculation
                    child: GridView.builder(
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String condition;
  final String price;
  final String status;

  ProductCard({
    required this.imageUrl,
    required this.name,
    required this.condition,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      condition,
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            status,
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: Icon(Icons.favorite_border,
                color: Colors.grey[600], size: 20.sp),
          ),
        ],
      ),
    );
  }
}
