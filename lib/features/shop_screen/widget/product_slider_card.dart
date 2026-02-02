// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';

class ProductSliderCard extends StatefulWidget {
  const ProductSliderCard({
    super.key,
    required this.images,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
    required this.width,
    required this.height,
    this.borderRadius = 16,
  });

  final List images;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;
  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ProductSliderCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductSliderCard> {
  late final PageController _pageController;
  int _index = 0;
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
    _favorite = widget.isFavorite;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(widget.borderRadius + 2),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.06),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Slider
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => Container(
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  child: ShimmerImage(
                    imageUrl: widget.images[i], 
                    placeholder: AppImages.placeholderImage, 
                    height: 260.h, width: double.infinity, boxFit: BoxFit.contain, borderRadius: 0,
                  )
                ),
              ),
            ),
        
            // Heart (favorite) button (top-right)
            Positioned(
              top: 12,
              right: 12,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    setState(() => _favorite = !_favorite);
                    widget.onFavoriteToggle?.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      _favorite ? Icons.favorite : Icons.favorite_border,
                      size: 22,
                      color: _favorite ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
        
            // * Dots indicator (bottom-center)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (i) {
                  final selected = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: selected ? 12 : 12,
                    width: selected ? 12 : 12,
                    decoration: BoxDecoration(
                      color: selected ? Colors.grey.shade600 : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
