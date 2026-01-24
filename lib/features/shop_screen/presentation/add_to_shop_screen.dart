// ignore_for_file: avoid_print, prefer_final_fields, unused_field

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Condition;
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/shop_screen/model/market_place_get_data_model.dart';
import 'package:twwillustration/features/shop_screen/presentation/list_successful_screen.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class AddToShopScreen extends StatefulWidget {
  const AddToShopScreen({super.key});

  @override
  State<AddToShopScreen> createState() => _AddToShopScreenState();
}

class _AddToShopScreenState extends State<AddToShopScreen> {
  final _nameController = TextEditingController();
  final _desController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();
  final _conditionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _mainImage;
  List<XFile?> _additionalImages = List.filled(5, null);
  List<String> _imagePaths = [];
  bool _isCategoryLoading = false;

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
            ..._additionalImages.asMap().entries.where((entry) => entry.value != null).map((entry) => entry.value!.path)
          ];
          // Print the image paths
          log('Image Paths: $_imagePaths');
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  String? _selectedSize;
  final List<String> _sizes = ['M', 'L', 'X', 'XL', 'XLL'];

  List<Category> _categories = [];
  List<Condition> _conditions = [];

  String? _selectedCategoryId;
  String? _selectedCondition;

  String? _selectedShippingOption;
  final List<String> _shippingOption = ['buyer_pays', 'free_shipping'];

  Future<void> fetchCategories() async {
    setState(() => _isCategoryLoading = true);
    print('>>>>>>>>>>>>>>>>>>>>>_isCategoryLoading : $_isCategoryLoading <<<<<<<<<<<<<<<<<<<<<<<<<<');

    try {
      print('>>>>>>>>>>>>>>>>>>>>>calling api <<<<<<<<<<<<<<<<<<<<<<<<<<');
      final success = await getCategoriesRxObj.getCategoriesRx();
      print('>>>>>>>>>>>>>>>>>>>>>success : $success <<<<<<<<<<<<<<<<<<<<<<<<<<');

      if (success) {
        marketPlaceGetDataRxObj.getMarketPlaceData.listen((response) {
          setState(() {
            _categories = response.data?.categories ?? [];
            _conditions = response.data?.conditions ?? [];
            _isCategoryLoading = false;
          });
          print('>>>>>>>>>>>>>>>>>>>>>_isCategoryLoading : $_isCategoryLoading <<<<<<<<<<<<<<<<<<<<<<<<<<');
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          print(_categories.first.toString());
          print(_conditions.first.toString());
          print('<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>');
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      setState(() => _isCategoryLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'PDF,JPG,PNG (max 10 MB)',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
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

                //********************** Product Name *******************************/
                Text(
                  'Item Name',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  height: 56.h,
                  controller: _nameController,
                  hintText: 'e.g. Vintage 90s Denim Jacket',
                ),
                UIHelper.verticalSpace(10.h),

                //********************** Product Descreption *******************************/
                Text(
                  'Descreption',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  hintText: "Describe your Item, Including condition,size, fit, etc.",
                  controller: _desController,
                  borderColor: AppColor.cE8E8E8,
                  maxline: 5,
                  height: 140.h,
                ),
                UIHelper.verticalSpace(10.h),

                //********************** Product Category *******************************/
                Text(
                  'Select Category',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                GestureDetector(
                  child: Container(
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColor.cFFFFFF,
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: _isCategoryLoading
                          ? Center(
                              child: SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedCategoryId,
                              hint: const Text('Select Category'),
                              items: _categories.map((Category item) {
                                return DropdownMenuItem<String>(
                                  value: item.id.toString(),
                                  child: Text(item.title ?? ''),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategoryId = value;
                                });
                              },
                            ),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSmall,

                //********************** Product Size *******************************/
                Text(
                  'Select Size',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedSize,
                      hint: Text(
                        'Select Size',
                        style: TextFontStyle.inter10W400.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: _sizes.map((size) {
                        return DropdownMenuItem<String>(
                          value: size,
                          child: Text(
                            size,
                            style: TextFontStyle.inter10W400.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSize = value;
                        });
                      },
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSmall,

                //********************** Product Brand *******************************/
                Text(
                  'Brand',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  height: 56.h,
                  controller: _brandController,
                  hintText: 'Brand Name',
                ),
                UIHelper.verticalSpace(10.h),

                //********************** Product Condation *******************************/
                Text(
                  'Condation',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: _isCategoryLoading
                      ? Center(
                          child: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedCondition,
                            hint: const Text('Select Condition'),
                            items: _conditions.map((Condition item) {
                              return DropdownMenuItem<String>(
                                value: item.value,
                                child: Text(item.name ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCondition = value;
                              });
                            },
                          ),
                        ),
                ),
                UIHelper.verticalSpaceSmall,

                //********************** Product Price *******************************/
                Text(
                  'Price',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                CustomTextField(
                  height: 56.h,
                  controller: _priceController,
                  hintText: 'Product Price',
                ),
                UIHelper.verticalSpace(10.h),

                //********************** Product Shipping Option *******************************/
                Text(
                  'Shipping Option',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedShippingOption,
                      hint: Text(
                        'Shipping Option',
                        style: TextFontStyle.inter10W400.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: _shippingOption.map((size) {
                        return DropdownMenuItem<String>(
                          value: size,
                          child: Text(
                            size,
                            style: TextFontStyle.inter10W400.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedShippingOption = value;
                        });
                      },
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSmall,

                //********************** Select from wardrobe *******************************/
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
                              style: TextFontStyle.Inter10W700.copyWith(
                                fontSize: 16.sp,
                                color: AppColor.blackColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'View All',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: _categories.map((category) {
                        //     final index = _categories.indexOf(category);
                        //     return GestureDetector(
                        //       onTap: () =>
                        //           setState(() => _selectedCategoryId = index),
                        //       child: Text(
                        //         category,
                        //         style: TextFontStyle.textStyle12w400NunitoSans
                        //             .copyWith(
                        //           fontSize: 14.sp,
                        //           color: _selectedCategory == index
                        //               ? Colors.black
                        //               : Colors.grey,
                        //           fontWeight: _selectedCategory == index
                        //               ? FontWeight.bold
                        //               : FontWeight.normal,
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _categories.map((category) {
                            final index = _categories.indexOf(category);
                            return GestureDetector(
                              onTap: () => setState(() => _selectedCategoryId = category.id.toString()),
                              child: Column(
                                children: [
                                  Text(
                                    category.title ?? '',
                                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                      fontSize: 14.sp,
                                      color: _selectedCategoryId == category.id.toString() ? Colors.black : Colors.grey,
                                      fontWeight: _selectedCategoryId == category.id.toString()
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
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
                            if (_selectedCategoryId == (_categories.isNotEmpty ? _categories[0].id.toString() : ''))
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
                              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
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
