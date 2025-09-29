// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/shop_screen/presentation/list_successful_screen.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class AddToShopScreen extends StatefulWidget {
  const AddToShopScreen({super.key});

  @override
  State<AddToShopScreen> createState() => _AddToShopScreenState();
}

class _AddToShopScreenState extends State<AddToShopScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _mainImage;
  List<XFile?> _additionalImages = List.filled(5, null);
  List<String> _imagePaths = [];

  // Function to pick image and update the state
  Future<void> _pickImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (index == -1) {
            _mainImage = image;
          } else {
            _additionalImages[index] = image;
          }
          // Update image paths list
          _imagePaths = [
            if (_mainImage != null) _mainImage!.path,
            ..._additionalImages
                .asMap()
                .entries
                .where((entry) => entry.value != null)
                .map((entry) => entry.value!.path)
          ];
          // Print the image paths
          log('Image Paths: $_imagePaths');
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  int _selectedCategory = 0;
  final List<String> _categories = ['Tops', 'Bottoms', 'Outerwear'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: 'Marketplace',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _pickImage(-1),
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _mainImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.cameraIcon,
                                height: 50.h,
                                width: 50.w,
                              ),
                              UIHelper.verticalSpace(10.h),
                              Text(
                                'Add Photo (${_imagePaths.length}/8)',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'PDF,JPG,PNG (max 10 MB)',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_mainImage!.path),
                              height: 150.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => _pickImage(index),
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: _additionalImages[index] == null
                              ? SvgPicture.asset(
                                  AppIcons.plusIcon,
                                  height: 30.h,
                                  width: 30.w,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_additionalImages[index]!.path),
                                    width: 60.w,
                                    height: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),
                ),
                UIHelper.verticalSpace(30.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Item Name',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "e.g. Vintage 90s Denim Jacket",
                  controller: TextEditingController(),
                  dropdownItems: ['Warm', 'Cold', 'Natural', 'Dark', 'Bright'],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Caption',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(5.h),
                CustomTextField(
                  hintText:
                      "Describe your Item, Including condition,size, fit, etc.",
                  controller: TextEditingController(),
                  borderColor: AppColor.cE8E8E8,
                  fieldColor: AppColor.cFFFFFF,
                  textSize: 14.sp,
                  maxline: 5,
                  height: 120.h,
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Price',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(5.h),
                CustomTextField(
                  hintText: "\$0.00",
                  controller: TextEditingController(),
                  borderColor: AppColor.cE8E8E8,
                  fieldColor: AppColor.cFFFFFF,
                  textSize: 14.sp,
                  maxline: 1,
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Category',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Top",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Top',
                    'Bottom',
                    'Left',
                    'Right',
                  ],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Condition',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Excellent",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Excellent',
                    'Good',
                    'Fair',
                    'Poor',
                  ],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Brand',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomTextField(
                  hintText: "Denim",
                  controller: TextEditingController(),
                  borderColor: AppColor.cE8E8E8,
                  fieldColor: AppColor.cFFFFFF,
                  textSize: 14.sp,
                  maxline: 1,
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Size',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Excellent",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Excellent',
                    'Good',
                    'Fair',
                    'Poor',
                  ],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Material',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Cotton",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Excellent',
                    'Good',
                    'Fair',
                    'Poor',
                  ],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select from wardrobe',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              'View All',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _categories.map((category) {
                            final index = _categories.indexOf(category);
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedCategory = index),
                              child: Text(
                                category,
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: _selectedCategory == index
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: _selectedCategory == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildClothingItem('H&M', 'Worn: 3'),
                            if (_selectedCategory == 0)
                              _buildClothingItem('Zara', 'Worn: 3'),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You have similar tops in your wardrobe',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14.sp,
                                color: AppColor.c000000,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 14.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CustomButton(
                  name: 'List',
                  onCallBack: () {
                    Get.to(() => ListSuccessfulScreen());
                  },
                  context: context,
                  color: AppColor.cD5E7B0,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClothingItem(String brand, String worn) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.femaleImage, fit: BoxFit.contain),
          ), // Placeholder for clothing image
        ),
        SizedBox(height: 8.h),
        Text(
          brand,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        Text(
          worn,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? leftIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? fieldColor;
  final double? textSize;
  final TextAlign? textAlign;
  final double? height;
  final GestureTapCallback? onTap;

  final List<String>? dropdownItems;
  final ValueChanged<String>? onChanged;

  const CustomDropDown({
    Key? key,
    this.hintText,
    this.controller,
    this.leftIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.validator,
    this.borderColor,
    this.fieldColor,
    this.textSize,
    this.textAlign = TextAlign.start,
    this.height = 55.0,
    this.onTap,
    this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _errorText;
  String? _selectedValue;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5, // dropdown নিচে show হবে
        width: size.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.dropdownItems!.map((item) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = item;
                      widget.controller?.text = item;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(item);
                    }
                    _removeDropdown();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            height: widget.height?.h ?? 50.h,
            decoration: BoxDecoration(
              color: widget.fieldColor ?? AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: widget.borderColor ??
                    (_errorText != null ? Colors.red : const Color(0xffe8e8e8)),
                width: 1.w,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Row(
              children: [
                if (widget.leftIcon != null) ...[
                  SvgPicture.asset(widget.leftIcon!, height: 20.h, width: 20.w),
                  SizedBox(width: 10.w),
                ],
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    readOnly: widget.dropdownItems != null,
                    validator: (value) {
                      final error = widget.validator?.call(value);
                      setState(() {
                        _errorText = error;
                      });
                      return null;
                    },
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: Colors.black,
                      fontSize: widget.textSize ?? 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    cursorColor: AppColor.blackColor,
                    textAlign: widget.textAlign ?? TextAlign.start,
                    onTap: widget.dropdownItems != null
                        ? _toggleDropdown
                        : widget.onTap,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle:
                          TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        color: AppColor.cC7C7C7,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                      errorText: null,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                  ),
                ),
                if (widget.dropdownItems != null) ...[
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _toggleDropdown,
                    child: Icon(
                      _isDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.c979797,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 8.w),
            child: Text(
              _errorText!,
              style: TextFontStyle.textStyle12w400NunitoSans
                  .copyWith(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
