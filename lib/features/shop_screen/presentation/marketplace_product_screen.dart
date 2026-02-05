import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/features/shop_screen/widget/marketplace_screen_shimmer.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class MarketplaceProductScreen extends StatefulWidget {
  const MarketplaceProductScreen({super.key});

  @override
  State<MarketplaceProductScreen> createState() => _MarketplaceProductScreenState();
}

class _MarketplaceProductScreenState extends State<MarketplaceProductScreen> {
  bool isLoading = true;

  List<GetMarketplaceProductModel> _allProducts = [];

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
      appBar: CustomAppbar(
        title: 'Marketplace',
        actions: [
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
          UIHelper.horizontalSpace(16.w)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          children: [
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
                                    color: selectedCategoryIndex == index ? AppColor.primaryColors : Colors.grey[200]),
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
                                color: selectedCategoryIndex == index ? AppColor.primaryColors : Colors.grey[200],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                button?.title ?? '',
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
            UIHelper.verticalSpaceMedium,
            isLoading || _allProducts.isEmpty
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
                          itemCount: _allProducts.first.data?.length,
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
                                  bool success =
                                      await toggleFavoriteUnfovariteRxObj.toggleFavoriteUnfovariteRx(product?.id ?? 0);
                                  if (!success) {
                                    setState(() {
                                      product?.isFav = wasFollowing;
                                    });
                                    await getMarketplaceProductRxObj.getMarketplaceProductRx('', '');
                                  }
                                },
                                favoriteIcon: (product?.isFav ?? false) ? Icons.favorite : Icons.favorite_border);
                          },
                        ),
                      ),
            UIHelper.verticalSpaceMediumLarge
          ],
        ),
      ),
    );
  }
}
