import 'package:flutter/material.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<_WishItem> _items = List.generate(
    4,
    (i) => _WishItem(
      title: 'Summer Fashion',
      subtitle: 'Worn 12x',
      price: 78.99,
      image: AppImages.dressImage, // তোমার অ্যাসেট ইমেজ দিন
      condition: 'Excellent',
      liked: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // ফলোব্যাক কালার (যদি AppColor না থাকে তাহলে এইগুলো ইউজ করতে পারো)
    // final bg = const Color(0xFFF3F5F7);
    // final cardBg = Colors.white;

    return Scaffold(
      backgroundColor: AppColor.cF3F5F7, // bg
      appBar: CustomAppbar(
        title: 'Wishlist',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: _items.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            // Section header
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'My Favorite',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }

            final item = _items[index - 1];

            return _WishlistCard(
              item: item,
              onToggleLike: () {
                setState(() => item.liked = !item.liked);
              },
            );
          },
        ),
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  const _WishlistCard({
    required this.item,
    required this.onToggleLike,
  });

  final _WishItem item;
  final VoidCallback onToggleLike;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // cardBg
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Image area (slightly inset rounded container like mock)
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.image,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + like
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _LikeButton(liked: item.liked, onTap: onToggleLike),
                  ],
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  item.subtitle,
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                // Price + condition pill
                Row(
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    _ConditionPill(label: item.condition),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton({required this.liked, required this.onTap});

  final bool liked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            shape: BoxShape.circle,
          ),
          child: Icon(
            liked ? Icons.favorite : Icons.favorite_border,
            size: 18,
            color: liked ? Colors.red : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class _ConditionPill extends StatelessWidget {
  const _ConditionPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _WishItem {
  _WishItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.condition,
    this.liked = false,
  });

  final String title;
  final String subtitle;
  final double price;
  final String image;
  final String condition;
  bool liked;
}
