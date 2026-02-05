import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String condition;
  final String price;
  final VoidCallback onTap;
  final VoidCallback toggleFavorite;
  final IconData favoriteIcon;
  final VoidCallback toggleCart;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.condition,
    required this.price,
    required this.onTap,
    required this.toggleFavorite,
    required this.favoriteIcon, required this.toggleCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                ShimmerImage(
                  imageUrl: imageUrl,
                  placeholder: AppImages.placeholderImage,
                  height: 140.h,
                  width: double.infinity,
                  boxFit: BoxFit.contain,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          condition,
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '\$$price',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: toggleCart,
                              child: Icon(Icons.shopping_cart_outlined, size: 20.sp,),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    favoriteIcon,
                    color: Colors.red,
                    size: 25.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
