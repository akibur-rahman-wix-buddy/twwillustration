import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

// Full Screen Image Viewer with Enhanced Zoom
class FullScreenImageViewer extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.imagePaths,
    this.initialIndex = 0,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;
  final TransformationController _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // Listen to zoom changes
    _transformationController.addListener(_onTransformationChanged);
  }

  void _onTransformationChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    setState(() {
      _isZoomed = scale > 1.0;
    });
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      // If zoomed in, zoom out
      _transformationController.value = Matrix4.identity();
    } else {
      // If zoomed out, zoom in to the tapped position
      final position = _doubleTapDetails!.localPosition;
      const double scale = 2.5;
      final x = -position.dx * (scale - 1);
      final y = -position.dy * (scale - 1);
      final zoomed = Matrix4.identity()
        ..translate(x, y)
        ..scale(scale);
      _transformationController.value = zoomed;
    }
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.imagePaths.length}',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: _isZoomed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
        itemCount: widget.imagePaths.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            _resetZoom();
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTapDown: _handleDoubleTapDown,
            onDoubleTap: _handleDoubleTap,
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: true,
              scaleEnabled: true,
              minScale: 0.5,
              maxScale: 4.0, // Allow free panning in all directions
              panAxis: PanAxis.free, // No axis restriction
              child: Center(
                child: Image.file(
                  File(widget.imagePaths[index]),
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  List<Message> messages = [
    Message(
      text: "Hi! I'm interested in your vintage Levi's jacket. Is it still available?",
      time: "10:45 AM",
      isSent: true,
    ),
    Message(
      text: "Hi! I'm interested in your vintage Levi's jacket. Is it still available?",
      time: "10:45 AM",
      isSent: false,
    ),
    Message(
      text: "Great! Could you share more photos of the back and sleeves?",
      time: "10:45 AM",
      isSent: true,
    ),
    Message(
      text: "Hi! I'm interested in your vintage Levi's jacket. Is it still available?",
      time: "10:45 AM",
      isSent: false,
    ),
    Message(
      text: "Great! Could you share more photos of the back and sleeves?",
      time: "10:45 AM",
      isSent: true,
    ),
  ];

  // Pick multiple images from gallery
  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        imageQuality: 70,
      );

      if (pickedFiles.isNotEmpty) {
        List<String> imagePaths = pickedFiles.map((file) => file.path).toList();

        setState(() {
          messages.add(
            Message(
              text: pickedFiles.length > 1 ? '${pickedFiles.length} photos' : 'Photo',
              time: _getCurrentTime(),
              isSent: true,
              imagePaths: imagePaths,
            ),
          );
        });

        _scrollToBottom();
      }
    } catch (e) {
      _showSnackBar('Error picking images: $e');
    }
  }

  // Take photo from camera
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
      );

      if (photo != null) {
        setState(() {
          messages.add(
            Message(
              text: 'Photo',
              time: _getCurrentTime(),
              isSent: true,
              imagePaths: [photo.path],
            ),
          );
        });

        _scrollToBottom();
      }
    } catch (e) {
      _showSnackBar('Error taking photo: $e');
    }
  }

  // Show image picker options bottom sheet
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.cD5E7B0.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  AppIcons.cameraIcon,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              title: Text(
                'Take Photo',
                style: TextFontStyle.Inter10W600.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.c000000,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            UIHelper.verticalSpaceSmall,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.cD5E7B0.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.photo_library,
                  color: AppColor.c000000,
                  size: 24.w,
                ),
              ),
              title: Text(
                'Choose from Gallery',
                style: TextFontStyle.Inter10W600.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.c000000,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImages();
              },
            ),
            UIHelper.verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        Message(
          text: _messageController.text,
          time: _getCurrentTime(),
          isSent: true,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // Scroll to 0 because list is reversed
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _openImageViewer(List<String> imagePaths, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          imagePaths: imagePaths,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildImageGrid(List<String> imagePaths) {
    final displayImages = imagePaths.take(4).toList();
    final remainingCount = imagePaths.length - 4;
    final hasMore = remainingCount > 0;

    // Single image
    if (displayImages.length == 1) {
      return GestureDetector(
        onTap: () => _openImageViewer(imagePaths, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(
            File(displayImages[0]),
            width: MediaQuery.of(context).size.width * 0.6,
            height: 200.h,
            fit: BoxFit.cover,
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
              onTap: () => _openImageViewer(imagePaths, index),
              child: Container(
                margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    File(displayImages[index]),
                    height: 200.h,
                    fit: BoxFit.cover,
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
            onTap: () => _openImageViewer(imagePaths, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.file(
                File(displayImages[0]),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 150.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: List.generate(2, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => _openImageViewer(imagePaths, index + 1),
                  child: Container(
                    margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        File(displayImages[index + 1]),
                        height: 100.h,
                        fit: BoxFit.cover,
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
                onTap: () => _openImageViewer(imagePaths, index),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == 0 ? 2.w : 0,
                    bottom: 2.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(displayImages[index]),
                      height: 100.h,
                      fit: BoxFit.cover,
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
                onTap: () => _openImageViewer(imagePaths, imageIndex),
                child: Container(
                  margin: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          File(displayImages[imageIndex]),
                          height: 100.h,
                          fit: BoxFit.cover,
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.backIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            ShimmerClipOvalWidget(
              height: 40.w,
              weight: 40.w,
              networkImageLink: 'https://i.pravatar.cc/150?img=12',
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chris Glasser',
                  style: TextFontStyle.Inter10W600.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                  ),
                ),
                Text(
                  'Active Now',
                  style: TextFontStyle.inter10W400.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.c757575,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true, // Messages start from bottom
              padding: EdgeInsets.all(16.w),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // Reverse the index to show messages in correct order
                final reversedIndex = messages.length - 1 - index;
                final message = messages[reversedIndex];
                return Align(
                  alignment: message.isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: message.isSent ? const Color(0xFFDCF8C6) : Colors.white,
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
                      crossAxisAlignment: message.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Display images if available
                        if (message.imagePaths != null && message.imagePaths!.isNotEmpty)
                          Column(
                            children: [
                              _buildImageGrid(message.imagePaths!),
                              SizedBox(height: 6.h),
                            ],
                          ),
                        // Display text message
                        Text(
                          message.text,
                          style: TextFontStyle.inter10W400.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          message.time,
                          style: TextFontStyle.inter10W400.copyWith(
                            fontSize: 11.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom Input Area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(AppIcons.cameraIcon),
                    onPressed: _showImagePickerOptions,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TextField(
                        controller: _messageController,
                        onSubmitted: (value) => _sendMessage(),
                        style: TextFontStyle.inter10W400.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.c000000,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type a Message',
                          hintStyle: TextFontStyle.inter10W400.copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.cD5E7B0,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(AppIcons.sendsIcon),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final String time;
  final bool isSent;
  final List<String>? imagePaths;

  Message({
    required this.text,
    required this.time,
    required this.isSent,
    this.imagePaths,
  });
}
