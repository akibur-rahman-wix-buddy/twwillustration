import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchController = TextEditingController();

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
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: '',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                    CustomTextField(
                  controller: _searchController,
                  hintText: 'Search here.....',
                  onChanged: (value) {},
                ),
                UIHelper.verticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Search',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Clear',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          color: AppColor.c000000,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(16.h),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.refreshIcon,
                                height: 14.h,
                                width: 14.w,
                              ),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                'Jacket',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Products',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.c000000,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
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
                          status: products[index]['status'], onTap: () {},
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
