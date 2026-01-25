import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_details_model.dart';
import 'package:twwillustration/features/shop_screen/widget/list_successfull_page_shimmer_widget.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class ListSuccessfulScreen extends StatefulWidget {
  final int productId;

  const ListSuccessfulScreen({super.key, required this.productId});

  @override
  State<ListSuccessfulScreen> createState() => _ListSuccessfulScreenState();
}

class _ListSuccessfulScreenState extends State<ListSuccessfulScreen> {
  bool isLoading = false;

  List<GetMarketplaceProductDetailsModel> productDetails = [];

  Future<void> fetchProductDetails(int productId) async {
    try {
      setState(() => isLoading = true);

      print('>>>>>>>>>>>>> isLoading : $isLoading <<<<<<<<<<<<<<<<<<<<<<');

      bool success = await getMarketplaceProductDetailsRxObj.getMarketplaceProductDetailsRx(productId);

      if (success) {
        print('>>>>>>>>>>>>> success : $success <<<<<<<<<<<<<<<<<<<<<<');
        getMarketplaceProductDetailsRxObj.getMarketplaceProductDetailsData.listen((product) {
          setState(() {
            productDetails = [product];
            isLoading = false;
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('error during : $error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: 'Marketplace Item',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: isLoading || productDetails.isEmpty
                ? MarketplaceSuccessShimmer()
                : Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.successIcon,
                              ),
                              UIHelper.verticalSpace(10.h),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Your vintage item has been successfully Added to Marketplace!",
                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              UIHelper.verticalSpace(10.h),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Your item has been successfully added to marketplace and is now visible to shoppers",
                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        height: 110.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            ShimmerImage(
                                imageUrl: productDetails.first.data?.product?.images?.first ?? '',
                                placeholder: AppImages.placeholderImage,
                                height: double.infinity,
                                width: 93.w),
                            UIHelper.horizontalSpace(10.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${productDetails.first.data?.product?.title}',
                                      style: TextFontStyle.inter10W400
                                          .copyWith(fontSize: 14.sp, color: AppColor.c2F2F2F),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.cF3F5F7,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColor.c000000.withValues(alpha: .2),
                                      ),
                                    ),
                                    child: Text(
                                      productDetails.first.data?.product?.condition ?? '',
                                      style:
                                          TextFontStyle.inter10W400.copyWith(fontSize: 12.sp, color: AppColor.c757575),
                                    ),
                                  ),
                                  Text(
                                    "\$${productDetails.first.data?.product?.price}",
                                    style: TextFontStyle.Inter10W600.copyWith(fontSize: 14.sp, color: AppColor.c2F2F2F),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(20.h),
                      CustomButton(
                        name: 'View Your Product',
                        onCallBack: () {},
                        borderRadius: 25.r,
                        context: context,
                        color: AppColor.cD5E7B0,
                        textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor,
                        ),
                      ),
                      UIHelper.verticalSpace(20.h),
                      CustomButton(
                        name: 'Go To Markrtplace',
                        onCallBack: () {
                          NavigationService.goBack;
                        },
                        borderRadius: 25.r,
                        context: context,
                        color: AppColor.cFFFFFF,
                        textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor,
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
