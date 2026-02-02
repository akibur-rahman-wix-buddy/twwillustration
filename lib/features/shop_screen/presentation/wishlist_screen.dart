import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/features/shop_screen/model/get_wishlist_product_data_model.dart';
import 'package:twwillustration/features/shop_screen/widget/favorite_product_shimmer.dart';
import 'package:twwillustration/features/shop_screen/widget/favorite_product_widget.dart';
import 'package:twwillustration/networks/api_acess.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isLoading = false;

  GetWishlistProductDataModel? _wishlistProducts;

  Future<void> fetchWishlistProduct() async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await getWishlistProductRxObj.gettWishlistProductRx();

      if (success) {
        getWishlistProductRxObj.gettWishlistProductData.listen((product) {
          setState(() {
            _wishlistProducts = product;
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('>>>>>>>>>>error during : $error <<<<<<<<<<<<<<<');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWishlistProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor, // bg
      appBar: CustomAppbar(
        title: 'Wishlist',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: isLoading
              ? WishlistShimmerItem()
              : _wishlistProducts == null || _wishlistProducts!.data!.isEmpty
                  ? Text('No Product Found')
                  : ListView.builder(
                      itemCount: _wishlistProducts?.data?.length,
                      itemBuilder: (context, index) {
                        final item = _wishlistProducts?.data?[index];
                        return FavoriteProductWidget(
                          imagePath: 'https://images.pexels.com/photos/35755658/pexels-photo-35755658.jpeg',
                          onTap: () {},
                          title: item?.product?.title ?? '',
                          price: item?.product?.price ?? 00,
                          toggleFavorite: () async {
                            bool favorite = false;
                            setState(() {
                              favorite = !favorite;
                            });
                            bool success =
                                await toggleFavoriteUnfovariteRxObj.toggleFavoriteUnfovariteRx(item?.product?.id ?? 0);
                            if (success) {
                              await fetchWishlistProduct();
                              await getMarketplaceProductRxObj.getMarketplaceProductRx('', '');
                            }
                          },
                          condation: item?.product?.condition ?? '',
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
