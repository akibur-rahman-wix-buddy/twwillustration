import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(List<XFile>)? onImagesSelected;
  final Function(XFile)? onImageCaptured;
  final bool allowMultiple;

  const ImagePickerBottomSheet({
    super.key,
    this.onImagesSelected,
    this.onImageCaptured,
    this.allowMultiple = true,
  });

  static Future<void> show({
    required BuildContext context,
    Function(List<XFile>)? onImagesSelected,
    Function(XFile)? onImageCaptured,
    bool allowMultiple = true,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ImagePickerBottomSheet(
        onImagesSelected: onImagesSelected,
        onImageCaptured: onImageCaptured,
        allowMultiple: allowMultiple,
      ),
    );
  }

  Future<void> _pickImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      if (allowMultiple) {
        final List<XFile>? pickedFiles = await picker.pickMultiImage(
          imageQuality: 70,
        );

        if (Navigator.canPop(context)) Navigator.pop(context);

        if (pickedFiles != null && pickedFiles.isNotEmpty && onImagesSelected != null) {
          onImagesSelected!(pickedFiles);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No images selected')),
          );
        }
      } else {
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
        );

        if (Navigator.canPop(context)) Navigator.pop(context);

        if (pickedFile != null && onImageCaptured != null) {
          onImageCaptured!(pickedFile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
      );

      if (Navigator.canPop(context)) Navigator.pop(context);

      if (photo != null && onImageCaptured != null) {
        onImageCaptured!(photo);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No photo captured')),
        );
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking photo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Image Source',
            style: TextFontStyle.inter10W600.copyWith(
              fontSize: 18.sp,
              color: AppColor.c000000,
            ),
          ),
          UIHelper.verticalSpaceMedium,
          ListTile(
            leading: Icon(Icons.camera, size: 30.sp),
            title: Text(
              'Take Photo',
              style: TextFontStyle.inter10W600.copyWith(
                fontSize: 16.sp,
                color: AppColor.c000000,
              ),
            ),
            subtitle: Text(
              'Use camera to take a photo',
              style: TextFontStyle.inter10W400.copyWith(
                fontSize: 12.sp,
                color: AppColor.c757575,
              ),
            ),
            onTap: () => _pickImageFromCamera(context),
          ),
          UIHelper.verticalSpaceSmall,
          ListTile(
            leading: Icon(Icons.photo_library, size: 30.sp),
            title: Text(
              allowMultiple ? 'Choose from Gallery' : 'Choose Image',
              style: TextFontStyle.inter10W600.copyWith(
                fontSize: 16.sp,
                color: AppColor.c000000,
              ),
            ),
            subtitle: Text(
              allowMultiple ? 'Select multiple images' : 'Select one image',
              style: TextFontStyle.inter10W400.copyWith(
                fontSize: 12.sp,
                color: AppColor.c757575,
              ),
            ),
            onTap: () => _pickImages(context),
          ),
          UIHelper.verticalSpaceSmall,
        ],
      ),
    );
  }
}
