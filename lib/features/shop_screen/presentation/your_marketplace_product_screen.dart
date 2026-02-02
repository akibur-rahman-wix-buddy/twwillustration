import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/features/shop_screen/model/get_your_marketplace_product.dart';
import 'package:twwillustration/features/shop_screen/widget/your_marketplace_product_widget.dart';
import 'package:twwillustration/networks/api_acess.dart';

class YourMarketplaceProductScreen extends StatefulWidget {
  const YourMarketplaceProductScreen({super.key});

  @override
  State<YourMarketplaceProductScreen> createState() =>
      _YourMarketplaceProductScreenState();
}

class _YourMarketplaceProductScreenState
    extends State<YourMarketplaceProductScreen> {
  bool isLoading = true;
  GetYourMarketplaceProductModel? productResponse;

  @override
  void initState() {
    super.initState();
    fetchYourMarketplaceProduct();
  }

  Future<void> fetchYourMarketplaceProduct() async {
    try {
      bool success =
          await getYourMarketplaceProductRxObj.getYourMarketplaceProductRx();

      if (success) {
        getYourMarketplaceProductRxObj.getYourMarketplaceProductData
            .listen((data) {
          if (!mounted) return;
          setState(() {
            productResponse = data;
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      debugPrint('Error fetching products: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = productResponse?.data ?? [];

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(title: 'Your Marketplace Product'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: isLoading
            ? _buildShimmerGrid()
            : products.isEmpty
                ? _buildEmptyState()
                : _buildProductGrid(products),
      ),
    );
  }

  // ================= GRID WITH DATA =================
  Widget _buildProductGrid(List products) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1 / 1.4,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return YourMarketplaceProductWidget(
          imageUrl: product.closetImage ?? '',
          name: product.title ?? '',
          price: product.price ?? '',
          onTap: () {},
        );
      },
    );
  }

  // ================= SHIMMER GRID =================
  Widget _buildShimmerGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1 / 1.4,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => _buildShimmerItem(),
    );
  }

  // ================= EMPTY STATE =================
  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No Product Found in Your Marketplace',
        textAlign: TextAlign.center,
        style: TextFontStyle.inter10W800.copyWith(
          fontSize: 18,
          color: AppColor.c141414,
        ),
      ),
    );
  }

  // ================= SHIMMER ITEM =================
  Widget _buildShimmerItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14.h,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14.h,
            width: 80.w,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
