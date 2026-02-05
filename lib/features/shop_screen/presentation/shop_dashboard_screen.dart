import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/features/shop_screen/widget/marketplace_screen_shimmer.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class ShopDashboardScreen extends StatefulWidget {
  const ShopDashboardScreen({super.key});

  @override
  State<ShopDashboardScreen> createState() => _ShopDashboardScreenState();
}

class _ShopDashboardScreenState extends State<ShopDashboardScreen> {
  bool isLoading = true;

  List<GetMarketplaceProductModel> _allProducts = [];
  List<GetMarketplaceProductModel> _recentlyAdded = [];
  List<GetMarketplaceProductModel> _thisWeek = [];

  List<GetCategoriesDataModel> _categories = [];
  int selectedCategoryIndex = 0;

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

  Future<void> fetchCategories() async {
    setState(() => isLoading = true);
    try {
      bool success = await getCategoriesRxObj.getCategoriesRx();

      if (success) {
        getCategoriesRxObj.getCategoriesData.listen((categories) {
          setState(() {
            _categories = [categories];
            setState(() => isLoading = false);
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('error during category : $error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addToCart(int productId) async{
    try{
      bool success = await postAddToCartRxObj.postAddToCartRx(productId);

      if(success){
        ToastUtil.showShortToast('Product successfully added to cart');
      } else{
        throw Exception();
      }
    } catch(error){
      debugPrint('>>>>>>> Error during add to cart call : $error <<<<<<<<<<');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchMarketplaceProduct('', '');
    fetchCategories();
  }

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
            child: _allProducts.isEmpty || _categories.isEmpty
                ? ShopDashboardShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Marketplace',
                            style: TextFontStyle.inter10W700.copyWith(fontSize: 20.sp, color: AppColor.c2F2F2F),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(Routes.cartScreen);
                            },
                            child: Icon(Icons.shopping_cart_outlined),
                          ),
                          UIHelper.horizontalSpace(10.w),
                          GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(Routes.wishlistScreen);
                            },
                            child: Icon(Icons.favorite_border),
                          ),
                          UIHelper.horizontalSpace(10.w),
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
                              NavigationService.navigateTo(Routes.addToShop);
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
                      _categories.isEmpty || _categories.first.data == null
                          ? SizedBox.shrink()
                          : SizedBox(
                              height: 45.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: (_categories.first.data?.length ?? 0) + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryIndex = index;
                                          });
                                          fetchMarketplaceProduct('', '');
                                        },
                                        child: Container(
                                          width: 50.w,
                                          margin: EdgeInsets.only(right: 8.w),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30.r),
                                              color: selectedCategoryIndex == index
                                                  ? AppColor.primaryColors
                                                  : Colors.grey[200]),
                                          child: Center(
                                            child: Text(
                                              'All',
                                              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                color: (selectedCategoryIndex == index)
                                                    ? Colors.black87
                                                    : Colors.grey[600],
                                                fontWeight: (selectedCategoryIndex == index)
                                                    ? FontWeight.w600
                                                    : FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final button = _categories.first.data?[index - 1];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategoryIndex = index;
                                        });
                                        fetchMarketplaceProduct(button?.title, '');
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        margin: EdgeInsets.only(right: 12),
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: selectedCategoryIndex == index
                                              ? AppColor.primaryColors
                                              : Colors.grey[200],
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          button?.title ?? '',
                                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                            color: (selectedCategoryIndex == index) ? Colors.black87 : Colors.grey[600],
                                            fontWeight:
                                                (selectedCategoryIndex == index) ? FontWeight.w600 : FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
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
                        height: 222.h,
                        child: isLoading
                            ? productListShimmer()
                            : _allProducts.first.data!.isEmpty
                                ? Center(child: Text('No product found', style: TextFontStyle.inter10W800.copyWith(fontSize: 24.sp, color: AppColor.c000000,),))
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
                                              toggleCart: () async{
                                                await addToCart(product?.id ?? 0);
                                              },
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
                                                  (product?.isFav ?? false) ? Icons.favorite : Icons.favorite_border));
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
                            onTap: () {NavigationService.navigateTo(Routes.marketplaceProductScreen);},
                            child: Text(
                              'View All',
                              style: TextFontStyle.inter10W800.copyWith(
                                fontSize: 14.sp,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(16.h),
                      isLoading
                          ? productGridShimmer()
                          : _allProducts.first.data!.isEmpty
                              ? Center(child: Text('No product found', style: TextFontStyle.inter10W800.copyWith(fontSize: 24.sp, color: AppColor.c000000,)))
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
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
                                        toggleCart: () async{
                                                await addToCart(product?.id ?? 0);
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
                      UIHelper.verticalSpaceMediumLarge
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
