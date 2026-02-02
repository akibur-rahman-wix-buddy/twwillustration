import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/features/chat/model/get_specific_user_chat_data_model.dart';

class MessageBubble extends StatelessWidget {
  final Data message;
  final bool isSent;
  final Function(List<String>, int)? onImageTap;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSent,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    // Check if both message and image are null/empty - skip rendering
    final hasMessage = message.message != null && message.message!.isNotEmpty;
    final hasImage = message.image != null && 
                     message.image.toString() != 'null' && 
                     message.image.toString().isNotEmpty;

    // Don't show bubble if no content
    if (!hasMessage && !hasImage) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSent ? const Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Display image if available
            if (hasImage)
              Column(
                children: [
                  _buildMessageImage(context),
                  SizedBox(height: 6.h),
                ],
              ),
            // Display text message
            if (hasMessage)
              Text(
                message.message!,
                style: TextFontStyle.inter10W400.copyWith(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
            SizedBox(height: 4.h),
            Text(
              _formatTime(message.messageAt),
              style: TextFontStyle.inter10W400.copyWith(
                fontSize: 11.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageImage(BuildContext context) {
    // If image is a list of URLs
    if (message.image is List) {
      final images = (message.image as List).map((e) => e.toString()).toList();
      if (images.isEmpty) return const SizedBox.shrink();
      
      return _buildImageGrid(context, images);
    } 
    // If image is a single URL string
    else if (message.image is String && message.image.toString().isNotEmpty) {
      final imageUrl = message.image.toString();
      
      return GestureDetector(
        onTap: () => onImageTap?.call([imageUrl], 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width * 0.6,
            height: 200.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 200.h,
                color: Colors.grey[300],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint('>>>>>> Image load error: $error <<<<<<');
              debugPrint('>>>>>> Image URL: $imageUrl <<<<<<');
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 200.h,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.broken_image, size: 50),
                    SizedBox(height: 8.h),
                    Text(
                      'Failed to load image',
                      style: TextFontStyle.inter10W400.copyWith(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildImageGrid(BuildContext context, List<String> imagePaths) {
    final displayImages = imagePaths.take(4).toList();
    final remainingCount = imagePaths.length - 4;
    final hasMore = remainingCount > 0;

    // Single image
    if (displayImages.length == 1) {
      return GestureDetector(
        onTap: () => onImageTap?.call(imagePaths, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.network(
            displayImages[0],
            width: MediaQuery.of(context).size.width * 0.6,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 200.h,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              );
            },
          ),
        ),
      );
    }

    // Two images
    if (displayImages.length == 2) {
      return Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onImageTap?.call(imagePaths, index),
              child: Container(
                margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    displayImages[index],
                    height: 200.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200.h,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }),
      );
    }

    // Three images
    if (displayImages.length == 3) {
      return Column(
        children: [
          GestureDetector(
            onTap: () => onImageTap?.call(imagePaths, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                displayImages[0],
                width: MediaQuery.of(context).size.width * 0.6,
                height: 150.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 150.h,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: List.generate(2, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => onImageTap?.call(imagePaths, index + 1),
                  child: Container(
                    margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        displayImages[index + 1],
                        height: 100.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100.h,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      );
    }

    // Four or more images (2x2 grid)
    return Column(
      children: [
        Row(
          children: List.generate(2, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onImageTap?.call(imagePaths, index),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == 0 ? 2.w : 0,
                    bottom: 2.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      displayImages[index],
                      height: 100.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100.h,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Row(
          children: List.generate(2, (index) {
            final imageIndex = index + 2;
            final isLast = imageIndex == 3 && hasMore;

            return Expanded(
              child: GestureDetector(
                onTap: () => onImageTap?.call(imagePaths, imageIndex),
                child: Container(
                  margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          displayImages[imageIndex],
                          height: 100.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100.h,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image),
                            );
                          },
                        ),
                      ),
                      if (isLast)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.6),
                              child: Center(
                                child: Text(
                                  '+$remainingCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String _formatTime(String? messageAt) {
    if (messageAt == null || messageAt.isEmpty) return '';
    
    try {
      final dateTime = DateTime.parse(messageAt);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      // If message is from today, show time only
      if (difference.inDays == 0) {
        final hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
        final minute = dateTime.minute.toString().padLeft(2, '0');
        final period = dateTime.hour >= 12 ? 'PM' : 'AM';
        return '$hour:$minute $period';
      }
      
      // If message is from yesterday
      if (difference.inDays == 1) {
        return 'Yesterday';
      }
      
      // If message is from this week
      if (difference.inDays < 7) {
        final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        return days[dateTime.weekday % 7];
      }
      
      // For older messages, show date
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return messageAt;
    }
  }
}