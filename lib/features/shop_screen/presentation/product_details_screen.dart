import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/shop_screen/presentation/shop_dashboard_screen.dart';
import 'package:twwillustration/features/shop_screen/widget/product_slider_card.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final _questionController = TextEditingController();

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

  // ডেমো ইমেজগুলো (assets থেকে)
  final demoImages = [
    const AssetImage(AppImages.imageOne),
    const AssetImage(AppImages.imageTwo),
    const AssetImage(AppImages.imageThree),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: 'Product Details',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // শুধু একটা প্রোডাক্ট কার্ড
              ProductSliderCard(
                width: double.infinity,
                height: 300,
                images: demoImages,
                isFavorite: false,
                onTap: () {},
              ),
              UIHelper.verticalSpace(20.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Crew-Neck Sweater',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '\$39.99',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.cF3F5F7,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              8,
                            ),
                            child: Text(
                              'Excelent',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.c000000,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    UIHelper.verticalSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Free Shipping',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.c000000,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Descriptions',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.c000000,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReadMoreText(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                        'Lorem Ipsum has been the industry\'s standard dummy text',
                        trimLines: 2,
                        colorClickableText:
                            const Color.fromARGB(255, 126, 188, 0),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '  Read More',
                        trimExpandedText: '   Show Less',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.c757575,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sizes',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.c000000,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColors,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            16,
                          ),
                          child: Text(
                            'M',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.c000000,
                            ),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          name: 'Chat',
                          onCallBack: () {},
                          context: context,
                          minWidth: 150.w,
                          color: AppColor.cFFFFFF,
                          borderColor: AppColor.primaryColors,
                          borderRadius: 80,
                          textStyle:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.c000000,
                          ),
                        ),
                        CustomButton(
                          name: 'Buy Now',
                          onCallBack: () {},
                          context: context,
                          minWidth: 150.w,
                          color: AppColor.primaryColors,
                          borderColor: AppColor.primaryColors,
                          borderRadius: 80,
                          textStyle:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.c000000,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(20.h),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.cFFFFFF,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    5,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Q&A about this item',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.c000000,
                        ),
                      ),
                      UIHelper.verticalSpace(
                        12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 190.w,
                            child: CustomTextField(
                              controller: _questionController,
                              hintText: 'Have a question? Ask here',
                            ),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          CustomButton(
                            name: 'Ask',
                            onCallBack: () {},
                            context: context,
                            minWidth: 80.w,
                            height: 50.h,
                            color: AppColor.primaryColors,
                            borderRadius: 80,
                            textStyle: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.c000000,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(12.h),
                      SizedBox(
                        height: 200, // প্রয়োজনমতো height দিন
                        child: ListView.builder(
                          itemCount: 2, // কয়বার দেখাতে চান
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColors,
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'Q',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.c000000,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      UIHelper.horizontalSpace(8.w),
                                      Text(
                                        'Is this sweater machine washable?',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.c000000,
                                        ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(8.h),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColors,
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'A',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.c000000,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      UIHelper.horizontalSpace(8.w),
                                      Text(
                                        'Yes, it\'s safe for machine wash in cold water.',
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.c757575,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: AppColor.c637381,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'View more questions',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 118, 176, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Similar items may you like!',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View all',
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
    );
  }
}
