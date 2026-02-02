import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/common_widgets/custom_snackbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/constants/app_constants.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
import 'package:twwillustration/features/shop_screen/data/add_marketplace/post_add_marketplace_api.dart';
import 'package:twwillustration/features/shop_screen/model/market_place_get_data_model.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/di.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
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

  final ImagePicker _picker = ImagePicker();
  bool isPosting = false;

  GetSingleClosetDataModel? singleCloset;

  List<XFile> _pickedImages = [];
  List<String> _networkImages = [];

  bool _isCategoryLoading = false;
  int? clothesId;

  Future<void> fetchSingleCloset(int closetId) async {
    try {
      bool success = await getSingleClosetRxObj.getSingleClosetRx(closetId);
      if (success) {
        getSingleClosetRxObj.getSingleClosetData.listen((closet) {
          if (mounted) {
            setState(() {
              singleCloset = closet;
            });
          }
        });
      }
    } catch (error) {
      debugPrint('fetchSingleCloset error: $error');
    }
  }

  Future<void> _pickImage() async {
    if (_networkImages.isEmpty) {
      showSnackBarMessage(context, 'প্রথমে wardrobe থেকে একটা item সিলেক্ট করুন');
      return;
    }

    try {
      final int remaining = 8 - _totalImageCount;
      if (remaining <= 0) {
        showSnackBarMessage(context, 'You can select max 8 photo');
        return;
      }

      final List<XFile> images = await _picker.pickMultiImage(imageQuality: 80);
      final selected = images.take(remaining).toList();

      setState(() {
        _pickedImages.addAll(selected);
      });
    } catch (e) {
      showSnackBarMessage(context, '$e');
    }
  }

  void _addFromWardrobe(String imageUrl) {
    if (imageUrl.isEmpty) return;

    setState(() {
      _networkImages.clear();
      _networkImages.add(imageUrl);
    });
  }

  void _removePickedImage(int index) {
    setState(() {
      _pickedImages.removeAt(index);
    });
  }

  int get _totalImageCount => _pickedImages.length + _networkImages.length;

  String? _selectedSize;
  final List<String> _sizes = ['M', 'L', 'X', 'XL', 'XXL'];

  List<Category> _categories = [];
  List<Condition> _conditions = [];

  String? _selectedCategoryId;
  String? _selectedCondition;

  String _selectedWardrobeCategoryIndex = '1';

  List<GetSingleCategoryDataModel> _clothesData = [];
  bool isClothesLoading = false;

  String? _selectedShippingOption;
  final List<String> _shippingOption = ['buyer_pays', 'free_shipping'];

  Future<void> fetchCategories() async {
    setState(() => _isCategoryLoading = true);
    try {
      final success = await marketPlaceGetDataRxObj.marketPlaceGetDataRx();
      if (success) {
        marketPlaceGetDataRxObj.getMarketPlaceData.listen((response) {
          if (!mounted) return;
          setState(() {
            _categories = response.data?.categories ?? [];
            _conditions = response.data?.conditions ?? [];
            _isCategoryLoading = false;
          });
        });
      }
    } catch (e) {
      debugPrint('fetchCategories error: $e');
    } finally {
      setState(() => _isCategoryLoading = false);
    }
  }

  Future<void> fetchSingleCategory(int userID, int? productId) async {
    try {
      setState(() => isClothesLoading = true);
      bool success = await getSingleCategoryRxObj.getSingleCategoryRx(userID, productId);
      if (success) {
        getSingleCategoryRxObj.getSingleCategoryData.listen((clothes) {
          if (mounted) {
            setState(() {
              _clothesData = [clothes];
            });
          }
        });
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() => isClothesLoading = false);
    }
  }

  Future<void> _submitMarketplace() async {
    try {
      setState(() => isPosting = true);
      List<String> allImages = [
        ..._pickedImages.map((e) => e.path),
        ..._networkImages,
      ];

      final response = await PostAddMarketplaceApi.instance.postAddMarketplaceApi(
        productId: clothesId!,
        images: allImages,
        title: _nameController.text,
        description: _desController.text,
        category: _selectedCategoryId!,
        size: _selectedSize!,
        brand: _brandController.text,
        condition: _selectedCondition!,
        price: _priceController.text,
        shippingOption: _selectedShippingOption!,
      );
      if (response['status']) {
        showSnackBarMessage(context, 'Product added successfully!');
        NavigationService.navigateToReplacementWithArgs(
            Routes.listSuccessfullScreen, {'productId': response['data']['id']});
      } else {
        showSnackBarMessage(context, response['message'] ?? 'Failed to add product');
      }
    } catch (e) {
      showSnackBarMessage(context, 'Error: $e');
    } finally {
      setState(() => isPosting = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchSingleCategory(appData.read(kKeyUserID), 1);
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
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              UIHelper.verticalSpace(10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(20.h),

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
                        validator: (value) {
                          return _validateField(value, 'Item name is required');
                        },
                      ),
                      UIHelper.verticalSpace(10.h),

                      //********************** Product Description *******************************/
                      Text(
                        'Description',
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
                        validator: (value) {
                          return _validateField(value, 'Item description is required');
                        },
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
                      Container(
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
                                      _selectedCategoryId = value ?? '1';
                                    });
                                  },
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
                        validator: (value) {
                          return _validateField(value, 'Brand is required');
                        },
                      ),
                      UIHelper.verticalSpace(10.h),

                      //********************** Product Condition *******************************/
                      Text(
                        'Condition',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        hintText: 'Product Price',
                        validator: (value) {
                          return _validateField(value, 'Price is required');
                        },
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
                      _buildWardrobeSection(),
                      UIHelper.verticalSpace(20.h),

                      //********************** Submit Button *******************************/
                      CustomButton(
                        name: isPosting ? 'Adding Marketplace...' : 'Add Marketplace',
                        onCallBack: () {
                          if (clothesId == null) {
                            showSnackBarMessage(context, 'Closet Id is null, Please select a Clothes in your wardrobe');
                          } else if (_totalImageCount == 0) {
                            showSnackBarMessage(context, 'At least one image is required');
                          } else if (_nameController.text.isEmpty) {
                            showSnackBarMessage(context, 'Item name is required');
                          } else if (_desController.text.isEmpty) {
                            showSnackBarMessage(context, 'Description is required');
                          } else if (_selectedCategoryId == null) {
                            showSnackBarMessage(context, 'Please select category');
                          } else if (_selectedSize == null) {
                            showSnackBarMessage(context, 'Please select size');
                          } else if (_brandController.text.isEmpty) {
                            showSnackBarMessage(context, 'Brand is required');
                          } else if (_selectedCondition == null) {
                            showSnackBarMessage(context, 'Please select condition');
                          } else if (_priceController.text.isEmpty) {
                            showSnackBarMessage(context, 'Price is required');
                          } else if (_selectedShippingOption == null) {
                            showSnackBarMessage(context, 'Please select shipping option');
                          } else {
                            _submitMarketplace();
                          }
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _networkImages.isNotEmpty ? _pickImage : null,
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: _networkImages.isEmpty ? Border.all(color: Colors.grey, width: 2) : null,
            ),
            child: _totalImageCount == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.cameraIcon,
                        height: 50.h,
                        width: 50.w,
                        colorFilter:
                            _networkImages.isEmpty ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
                      ),
                      UIHelper.verticalSpace(10.h),
                      Text(
                        'Add Photo ($_totalImageCount/8)',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: _networkImages.isEmpty ? Colors.grey : null,
                        ),
                      ),
                      if (_networkImages.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            '(প্রথমে wardrobe থেকে item সিলেক্ট করুন)',
                            style: TextStyle(color: Colors.redAccent, fontSize: 12.sp),
                          ),
                        ),
                    ],
                  )
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _networkImages.isNotEmpty
                            ? ShimmerImage(
                                imageUrl: _networkImages.first,
                                placeholder: AppImages.placeholderImage,
                                boxFit: BoxFit.contain,
                                height: double.infinity,
                                width: double.infinity,
                              )
                            : Image.file(
                                File(_pickedImages.first.path),
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                      ),
                      // Delete button শুধু gallery image হলে দেখাবে
                      if (_networkImages.isEmpty && _pickedImages.isNotEmpty)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _removePickedImage(0),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
        UIHelper.verticalSpace(20.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Additional images (gallery images only, since network is in main)
              ..._buildAdditionalImages(),
              if (_totalImageCount < 8)
                GestureDetector(
                  onTap: _networkImages.isNotEmpty ? _pickImage : null,
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      color: _networkImages.isNotEmpty ? Colors.white : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.plusIcon,
                        height: 30.h,
                        width: 30.w,
                        colorFilter:
                            _networkImages.isEmpty ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAdditionalImages() {
    List<Widget> widgets = [];

    // শুধু gallery images দেখাবে (network main-এ থাকবে)
    for (int i = 0; i < _pickedImages.length; i++) {
      widgets.add(
        _buildImageTile(
          isNetwork: false,
          imagePath: _pickedImages[i].path,
          onRemove: () => _removePickedImage(i),
        ),
      );
    }

    return widgets;
  }

  Widget _buildImageTile({
    required bool isNetwork,
    required String imagePath,
    VoidCallback? onRemove,
  }) {
    return Container(
      width: 60.w,
      height: 60.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isNetwork
                ? ShimmerImage(
                    imageUrl: imagePath,
                    placeholder: AppImages.placeholderImage,
                    boxFit: BoxFit.cover,
                    height: 60.h,
                    width: 60.w,
                  )
                : Image.file(
                    File(imagePath),
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
          ),
          if (onRemove != null)
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWardrobeSection() {
    return Container(
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
                  style: TextFontStyle.inter10W700.copyWith(
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedWardrobeCategoryIndex = category.id.toString());
                        fetchSingleCategory(appData.read(kKeyUserID), int.tryParse(category.id.toString()) ?? 0);
                        fetchSingleCloset(int.tryParse(category.id.toString()) ?? 0);
                      },
                      child: Text(
                        category.title ?? '',
                        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
                          color: _selectedWardrobeCategoryIndex == category.id.toString() ? Colors.black : Colors.grey,
                          fontWeight: _selectedWardrobeCategoryIndex == category.id.toString()
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 16.h),
            SizedBox(
              height: 100.h,
              child: _clothesData.isEmpty || _clothesData.first.data!.isEmpty
                  ? Center(
                      child: SizedBox(
                        height: 80.h,
                        width: 80.w,
                        child: Lottie.asset(
                          AppLotties.noDataFound,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _clothesData.first.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = _clothesData.first.data![index];
                        final imageUrl = item.image ?? '';

                        return _buildClothingItem(
                          imagePath: imageUrl,
                          onTap: () {
                            setState(() {
                              _addFromWardrobe(imageUrl);
                              clothesId = int.tryParse(item.id.toString());
                            });
                            print('>>>>>>>>>>>>>>>>>clothesId : $clothesId <<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
                          },
                        );
                      },
                    ),
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey, thickness: 0.5),
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
    );
  }

  Widget _buildClothingItem({required String imagePath, required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 93.w,
            height: 93.h,
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: ShimmerImage(
              imageUrl: imagePath,
              placeholder: AppImages.placeholderImage,
              height: double.infinity,
              width: double.infinity,
            )));
  }

  static String? _validateField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}
