import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart'
    show getCategoriesRxObj;

class ClosetDetailsScreen extends StatefulWidget {
  final Uint8List imageBytes;

  const ClosetDetailsScreen({super.key, required this.imageBytes});

  @override
  State<ClosetDetailsScreen> createState() => _ClosetDetailsScreenState();
}

class _ClosetDetailsScreenState extends State<ClosetDetailsScreen> {
  final _searchController = TextEditingController();
  late TextEditingController _occationContriller;
  late TextEditingController _brandController;
  final _colorController = TextEditingController();

  DateTime? purchasedDate;

  List<GetCategoriesDataModel> _liatOfCategories = [];

  final List<Map<String, dynamic>> _selectedCategories = [];
  final List<String> _colorList = [];

  String selectedVisibility = 'published';
  List<String> visibilityOptions = ['published', 'private'];

  String selectedSize = "M";
  final List<String> sizes = ["M", "L", "XL", "XXL"];

  Color _getCategoryColor(int index) {
    final colors = [
      Color(0xFFB8E6B8), // All - Light Green
      Color(0xFFF5E6A3), // Casual - Light Yellow
      Color(0xFFFFB3B3), // Work - Light Orange
      Color(0xFFFFB3D9), // Formal - Light Pink
      Color(0xFFB3D9FF), // Sport - Light Blue
    ];
    return colors[index % colors.length];
  }

  Future<void> fetchCategories() async {
    try {
      bool success = await getCategoriesRxObj.getCategoriesRx();

      if (success) {
        getCategoriesRxObj.getCategoriesData.listen((categories) {
          setState(() {
            _liatOfCategories = [categories];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _occationContriller = TextEditingController();
    _brandController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(AppIcons.backIcon)),
                    Text(
                      'Closet Details',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    )
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(
                        widget.imageBytes,
                        fit: BoxFit.contain,
                        height: 180.h,
                        width: 180.w,
                      )
                      // Image.asset(
                      //   AppImages.shirtImages,
                      //   fit: BoxFit.contain,
                      //   height: 180.h,
                      //   width: 180.w,
                      // ),
                      ),
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // * #######################
                        // * ####### Category
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 625.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 30.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.r),
                                              topRight: Radius.circular(20.r),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              // Header Row
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setModalState(() =>
                                                          _selectedCategories
                                                              .clear());
                                                      setState(() {
                                                        _selectedCategories
                                                            .clear();
                                                      });
                                                    },
                                                    child: Text(
                                                      'Reset',
                                                      style: TextFontStyle
                                                          .inter10W400
                                                          .copyWith(
                                                        fontSize: 16.sp,
                                                        color:
                                                            Color(0xFF2F2F2F),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Categories',
                                                    style: TextFontStyle
                                                        .Inter10W600.copyWith(
                                                      fontSize: 20.sp,
                                                      color: Color(0xFF2F2F2F),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    icon: Icon(
                                                        Icons.cancel_outlined,
                                                        size: 25.sp),
                                                  ),
                                                ],
                                              ),

                                              UIHelper.verticalSpace(16.h),

                                              // Search Field
                                              CustomTextField(
                                                controller: _searchController,
                                                fieldColor: Colors.transparent,
                                                borderColor: Colors.grey,
                                                height: 50.h,
                                                leftIcon: AppIcons.searchIcon,
                                                hintText: 'Search',
                                              ),

                                              UIHelper.verticalSpaceSmall,

                                              // Selected Categories Chips OR Placeholder
                                              _selectedCategories.isEmpty
                                                  ? Text(
                                                      "Max 5 categories can be selected",
                                                      style: TextFontStyle
                                                          .inter10W400
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  : Wrap(
                                                      spacing: 8,
                                                      runSpacing: 8,
                                                      children:
                                                          _selectedCategories
                                                              .asMap()
                                                              .entries
                                                              .map((entry) {
                                                        final index = entry.key;
                                                        final item =
                                                            entry.value;
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                _getCategoryColor(
                                                                    index),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                          child: Text(
                                                              item['title']),
                                                        );
                                                      }).toList(),
                                                    ),

                                              _selectedCategories.isNotEmpty
                                                  ? UIHelper.verticalSpaceSmall
                                                  : SizedBox.shrink(),

                                              // Category List
                                              _liatOfCategories.isEmpty
                                                  ? Center(
                                                      child: Text(
                                                          'No category found'))
                                                  : SizedBox(
                                                      height: 200.h,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            _liatOfCategories
                                                                    .first
                                                                    .data
                                                                    ?.length ??
                                                                0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final category =
                                                              _liatOfCategories
                                                                  .first
                                                                  .data?[index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setModalState(() {
                                                                if (category !=
                                                                    null) {
                                                                  final alreadyExists =
                                                                      _selectedCategories
                                                                          .any(
                                                                    (item) =>
                                                                        item[
                                                                            'id'] ==
                                                                        category
                                                                            .id,
                                                                  );

                                                                  if (!alreadyExists &&
                                                                      _selectedCategories
                                                                              .length <
                                                                          5) {
                                                                    setState(
                                                                        () {
                                                                      _selectedCategories
                                                                          .add({
                                                                        "id": category
                                                                            .id,
                                                                        "title":
                                                                            category.title,
                                                                      });
                                                                    });
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  category?.title ??
                                                                      '',
                                                                  style: TextFontStyle
                                                                      .inter10W400
                                                                      .copyWith(
                                                                    color: Color(
                                                                        0xFF757575),
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 1,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width:
                                    _selectedCategories.isEmpty ? 200.h : 250.h,
                                decoration: BoxDecoration(
                                  color: _selectedCategories.isEmpty
                                      ? AppColor.cD5E7B0
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5.0,
                                  ),
                                  child: _selectedCategories.isNotEmpty
                                      ? Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            ..._selectedCategories
                                                .take(3)
                                                .map((item) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: AppColor.cD5E7B0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Text(item['title']),
                                              );
                                            }),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF0F0F0),
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                              ),
                                              child: Text(
                                                'Add',
                                                style: TextFontStyle
                                                    .textStyle12w400NunitoSans
                                                    .copyWith(
                                                  fontSize: 16.sp,
                                                  color: AppColor.c000000,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Select Categories',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                fontSize: 16.sp,
                                                color: AppColor.c000000,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SvgPicture.asset(AppIcons.arrowNext)
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Category
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Occasion',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 30.h),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.r),
                                                topRight:
                                                    Radius.circular(20.r)),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Add Occation',
                                                  style: TextFontStyle
                                                      .Inter10W600.copyWith(
                                                    fontSize: 20.sp,
                                                    color: Color(0xFF2F2F2F),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: Icon(
                                                      Icons.cancel_outlined,
                                                      size: 25.sp),
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceMedium,
                                            CustomTextField(
                                              controller: _occationContriller,
                                              hintText: 'Work/ Birthday/ party',
                                            ),
                                            Spacer(),
                                            CustomButton(
                                                name: 'Save',
                                                textStyle:
                                                    TextFontStyle.Inter10W600
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                color: AppColor.cD5E7B0,
                                                borderRadius: 100,
                                                onCallBack: () {
                                                  setState(() {
                                                    _occationContriller =
                                                        _occationContriller;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                context: context)
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _occationContriller.text.isEmpty
                                      ? Color(0xFFF0F0F0)
                                      : AppColor.cD5E7B0,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5.0,
                                  ),
                                  child: Text(
                                    _occationContriller.text.isEmpty
                                        ? 'Add'
                                        : _occationContriller.text,
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Brand
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Brand',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 30.h),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.r),
                                                topRight:
                                                    Radius.circular(20.r)),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Add Brand',
                                                  style: TextFontStyle
                                                      .Inter10W600.copyWith(
                                                    fontSize: 20.sp,
                                                    color: Color(0xFF2F2F2F),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: Icon(
                                                      Icons.cancel_outlined,
                                                      size: 25.sp),
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceMedium,
                                            CustomTextField(
                                              controller: _brandController,
                                              hintText: 'Easy/ Denim/ Twelve',
                                            ),
                                            Spacer(),
                                            CustomButton(
                                                name: 'Save',
                                                textStyle:
                                                    TextFontStyle.Inter10W600
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                color: AppColor.cD5E7B0,
                                                borderRadius: 100,
                                                onCallBack: () {
                                                  setState(() {
                                                    _brandController =
                                                        _brandController;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                context: context)
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _brandController.text.isEmpty
                                      ? Color(0xFFF0F0F0)
                                      : AppColor.cD5E7B0,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5.0,
                                  ),
                                  child: Text(
                                    _brandController.text.isEmpty
                                        ? 'Add'
                                        : _brandController.text,
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Color
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Color',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 625.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 30.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.r),
                                              topRight: Radius.circular(20.r),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              // Header Row
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setModalState(() =>
                                                          _colorList.clear());
                                                    },
                                                    child: Text(
                                                      'Reset',
                                                      style: TextFontStyle
                                                          .inter10W400
                                                          .copyWith(
                                                        fontSize: 16.sp,
                                                        color:
                                                            Color(0xFF2F2F2F),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Add Colors',
                                                    style: TextFontStyle
                                                        .Inter10W600.copyWith(
                                                      fontSize: 20.sp,
                                                      color: Color(0xFF2F2F2F),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    icon: Icon(
                                                        Icons.cancel_outlined,
                                                        size: 25.sp),
                                                  ),
                                                ],
                                              ),

                                              UIHelper.verticalSpace(16.h),

                                              // Search Field
                                              CustomTextField(
                                                controller: _colorController,
                                                fieldColor: Colors.transparent,
                                                borderColor: Colors.grey,
                                                height: 50.h,
                                                hintText: 'Red/ Green/ Blue',
                                              ),

                                              UIHelper.verticalSpaceSmall,

                                              // Selected Categories Chips OR Placeholder
                                              _colorList.isEmpty
                                                  ? Text(
                                                      "Max 5 Colors can be Added",
                                                      style: TextFontStyle
                                                          .inter10W400
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  : Wrap(
                                                      spacing: 8,
                                                      runSpacing: 8,
                                                      children: _colorList
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        final index = entry.key;
                                                        final item =
                                                            entry.value;
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                _getCategoryColor(
                                                                    index),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                          child: Text(item),
                                                        );
                                                      }).toList(),
                                                    ),
                                              UIHelper.verticalSpaceSmall,
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _colorList.isEmpty
                                      ? Color(0xFFF0F0F0)
                                      : AppColor.cD5E7B0,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5.0,
                                  ),
                                  child: Text(
                                    'Add Colors',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Material
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Material',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Cotton',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Pattern
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pattern',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Striped',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.arrowNext)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Visibility
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visibility',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedVisibility,
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 16.sp,
                                    color: AppColor.c000000,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  items: visibilityOptions.map((option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedVisibility = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Visibility',
                        //       style: TextFontStyle.textStyle12w400NunitoSans
                        //           .copyWith(
                        //         fontSize: 16.sp,
                        //         color: AppColor.c000000,
                        //         fontWeight: FontWeight.w800,
                        //       ),
                        //     ),
                        //     UIHelper.horizontalSpaceSmall,
                        //     GestureDetector(
                        //       onTap: () {
                        //         DropdownButtonHideUnderline(
                        //           child: DropdownButton<String>(
                        //             value: selectedVisibility,
                        //             icon: Icon(Icons.arrow_drop_down),
                        //             style: TextFontStyle
                        //                 .textStyle12w400NunitoSans
                        //                 .copyWith(
                        //               fontSize: 16.sp,
                        //               color: AppColor.c000000,
                        //               fontWeight: FontWeight.w400,
                        //             ),
                        //             dropdownColor: Colors.white,
                        //             borderRadius: BorderRadius.circular(12.r),
                        //             items: visibilityOptions.map((option) {
                        //               return DropdownMenuItem<String>(
                        //                 value: option,
                        //                 child: Text(option),
                        //               );
                        //             }).toList(),
                        //             onChanged: (newValue) {
                        //               setState(() {
                        //                 selectedVisibility = newValue!;
                        //               });
                        //             },
                        //           ),
                        //         );
                        //       },
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           color: AppColor.cD5E7B0,
                        //           borderRadius: BorderRadius.circular(10.r),
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16,
                        //             vertical: 5.0,
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Text(
                        //                 'Only me',
                        //                 style: TextFontStyle
                        //                     .textStyle12w400NunitoSans
                        //                     .copyWith(
                        //                   fontSize: 16.sp,
                        //                   color: AppColor.c000000,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //               SvgPicture.asset(AppIcons.arrowNext)
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // * #######################
                        // * ####### Purchase Date
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Purchased Date',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        purchasedDate = pickedDate;
                                      });
                                    }
                                  },
                                  child: Text(
                                    purchasedDate == null ? 'Select date' : DateFormat('dd MMM yyyy').format(purchasedDate!),
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Size
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Size',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Row(
                              children: sizes.map((size) {
                                final isSelected = selectedSize == size;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColor.cD5E7B0
                                          : Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Text(
                                      size,
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Size',
                        //       style: TextFontStyle.textStyle12w400NunitoSans
                        //           .copyWith(
                        //         fontSize: 16.sp,
                        //         color: AppColor.c000000,
                        //         fontWeight: FontWeight.w800,
                        //       ),
                        //     ),
                        //     UIHelper.horizontalSpaceSmall,
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         color: AppColor.cD5E7B0,
                        //         borderRadius: BorderRadius.circular(10.r),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 16,
                        //           vertical: 5.0,
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             Text(
                        //               'L',
                        //               style: TextFontStyle
                        //                   .textStyle12w400NunitoSans
                        //                   .copyWith(
                        //                 fontSize: 16.sp,
                        //                 color: AppColor.c000000,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // * #######################
                        // * ####### Price
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '\$120',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // * #######################
                        // * ####### Season
                        UIHelper.verticalSpace(16.h),
                        Divider(
                          color: AppColor.cE8E8E8,
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Season',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c000000,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.cD5E7B0,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Winter',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
