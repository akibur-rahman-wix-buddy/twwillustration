import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/features/shop_screen/widget/marketplace_screen_shimmer.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;

  List<GetMarketplaceProductModel> _allProducts = [];
  List<GetMarketplaceProductModel> _popularProducts = [];

  final List<String> _recentSearch = ['t', 'g', 'gh', 'top', 'title', 'test'];

  Future<void> fetchMarketplaceProduct(String? category, String? search) async {
    setState(() => isLoading = true);
    try {
      bool success = await getMarketplaceProductRxObj.getMarketplaceProductRx(category, search);

      if (success) {
        getMarketplaceProductRxObj.getMarketplaceProductData.listen((product) {
          setState(() {
            _allProducts = [product];
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

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMarketplaceProduct('', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: '',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: _allProducts.isEmpty
              ? searchScreenShimmer()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _searchController,
                      rightIconButton: GestureDetector(onTap: () {
                        setState(() => _searchController.text = '');
                        fetchMarketplaceProduct('', '');
                      }, child: SvgPicture.asset(AppIcons.cancel)),
                      hintText: 'Search here.....',
                      onChanged: (value) {
                        setState(() {
                          _searchController.text = value;
                        });
                        fetchMarketplaceProduct('', value);
                      },
                    ),
                    UIHelper.verticalSpace(10.h),
                    _searchController.text.isEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                          color: AppColor.c000000, fontSize: 14.sp, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(16.h),
                                SizedBox(
                                  height: 30.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _recentSearch.length,
                                    itemBuilder: (context, index) {
                                      final item = _recentSearch[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _searchController.text = item;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                                  item,
                                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                    color: AppColor.c000000,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                UIHelper.verticalSpace(16.h),
                                Text(
                                  'Popular Products',
                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                UIHelper.verticalSpace(16.h),
                                SizedBox(
                                  height: 222.h,
                                  child: isLoading
                                      ? productListShimmer()
                                      : _allProducts.first.data!.isEmpty
                                          ? Center(
                                              child: Text(
                                              'No product found',
                                              style: TextFontStyle.inter10W800.copyWith(
                                                fontSize: 24.sp,
                                                color: AppColor.c000000,
                                              ),
                                            ))
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _allProducts.first.data?.length,
                                              itemBuilder: (context, index) {
                                                final product = _allProducts.first.data?[index];
                                                return Container(
                                                    width: 163.w,
                                                    margin: EdgeInsets.only(right: 10.w),
                                                    child: ProductCard(
                                                        imageUrl: product?.image ?? '',
                                                        name: product?.title ?? '',
                                                        condition: product?.condition ?? '',
                                                        price: product?.price ?? '',
                                                        onTap: () {
                                                          NavigationService.navigateToWithArgs(Routes.productDetailsScreen, {'productId' : product?.id ?? 0});
                                                        },
                                                        toggleFavorite: () async {
                                                          final wasFollowing = product?.isFav ?? false;
                                                          setState(() {
                                                            product?.isFav = !wasFollowing;
                                                          });
                                                          bool success = await toggleFavoriteUnfovariteRxObj
                                                              .toggleFavoriteUnfovariteRx(product?.id ?? 0);
                                                          if (!success) {
                                                            setState(() {
                                                              product?.isFav = wasFollowing;
                                                            });
                                                            await getMarketplaceProductRxObj.getMarketplaceProductRx(
                                                                '', '');
                                                          }
                                                        },
                                                        favoriteIcon: (product?.isFav ?? false)
                                                            ? Icons.favorite
                                                            : Icons.favorite_border));
                                              }),
                                ),
                              ],
                            ),
                          )
                        : isLoading
                            ? Expanded(child: SingleChildScrollView(child: productGridShimmer()))
                            : _allProducts.first.data!.isEmpty
                                ? Center(
                                    child: Text('No product found',
                                        style: TextFontStyle.inter10W800.copyWith(
                                          fontSize: 24.sp,
                                          color: AppColor.c000000,
                                        )))
                                : Expanded(
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 0.80,
                                      ),
                                      itemCount: ((_allProducts.first.data?.length ?? 0) > 5)
                                          ? 4
                                          : _allProducts.first.data?.length,
                                      itemBuilder: (context, index) {
                                        final product = _allProducts.first.data?[index];
                                        return ProductCard(
                                            imageUrl: product?.image ?? '',
                                            name: product?.title ?? '',
                                            condition: product?.condition ?? '',
                                            price: product?.price ?? '',
                                            onTap: () {
                                              NavigationService.navigateToWithArgs(Routes.productDetailsScreen, {'productId' : product?.id ?? 0});
                                            },
                                            toggleFavorite: () async {
                                              final wasFollowing = product?.isFav ?? false;
                                              setState(() {
                                                product?.isFav = !wasFollowing;
                                              });
                                              bool success = await toggleFavoriteUnfovariteRxObj
                                                  .toggleFavoriteUnfovariteRx(product?.id ?? 0);
                                              if (!success) {
                                                setState(() {
                                                  product?.isFav = wasFollowing;
                                                });
                                                await getMarketplaceProductRxObj.getMarketplaceProductRx('', '');
                                              }
                                            },
                                            favoriteIcon:
                                                (product?.isFav ?? false) ? Icons.favorite : Icons.favorite_border);
                                      },
                                    ),
                                  ),
                    UIHelper.verticalSpaceMediumLarge
                  ],
                ),
        ),
      ),
    );
  }
}
