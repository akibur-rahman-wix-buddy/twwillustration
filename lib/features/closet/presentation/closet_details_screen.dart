import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/common_widgets/custom_snakbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/closet/model/get_materilas_data_model.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/features/closet/model/post_add_closet_model.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/clothes_details_shimmer.dart';

class ClosetDetailsScreen extends StatefulWidget {
  final int closetId;

  const ClosetDetailsScreen({super.key, required this.closetId});

  @override
  State<ClosetDetailsScreen> createState() => _ClosetDetailsScreenState();
}

class _ClosetDetailsScreenState extends State<ClosetDetailsScreen> {
  final _searchController = TextEditingController();
  late TextEditingController _occationContriller;
  late TextEditingController _brandController;
  late TextEditingController _patternController;
  late TextEditingController _priceController;
  late TextEditingController _titleController;
  final _colorController = TextEditingController();

  GetSingleClosetDataModel? singleCloset;

  DateTime? purchasedDate;
  bool isLoading = false;

  List<GetCategoriesDataModel> _liatOfCategories = [];
  List<GetMaterialsDataModel> _materialList = [];

  final List<Map<String, dynamic>> _selectedCategories = [];
  final List<String> _colorList = [];

  String selectedVisibility = 'published';
  List<String> visibilityOptions = ['published', 'private'];

  String? selectedMaterials;

  bool changeVisibility = false;
  bool changeSeason = false;

  String? selectedSeason;
  List<String> seasonOption = ['Summer', 'Winter', 'Rainy', 'Spring', 'Autumn'];

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

  Future<void> fetchSingleCloset(int closetId) async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await getSingleClosetRxObj.getSingleClosetRx(closetId);

      if (success) {
        getSingleClosetRxObj.getSingleClosetData.listen((closet) {
          setState(() {
            singleCloset = closet;
            isLoading = false;
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

  Future<void> fetchMaterials() async {
    try {
      bool success = await getMaterialsRxObj.getMaterialsRx();

      if (success) {
        getMaterialsRxObj.getMaterialsData.listen((materials) {
          setState(() {
            _materialList = [materials];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> postAddCloset(PostAddClosetModel closet) async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await postAddClosetRxObj.postAddClosetRx(closet);
      if (success) {
        showSnackBarMessage('Closet Added Sucessfully');
        setState(() {
          isLoading = false;
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
    fetchSingleCloset(widget.closetId);
    fetchCategories();
    fetchMaterials();
    _occationContriller = TextEditingController();
    _brandController = TextEditingController();
    _patternController = TextEditingController();
    _priceController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? ClosetDetailsShimmer()
              : Padding(
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
                            'Closet  Details',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 20.sp,
                              color: AppColor.c000000,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // PopupMenuButton<String>(
                          //   onSelected: (value) {
                          //     if (value == 'delete') {
                          //       print("Delete pressed");
                          //     } else if (value == 'marketplace') {
                          //       print("Move to Marketplace pressed");
                          //     }
                          //   },
                          // ),
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                                child: PopupMenuButton<String>(
                                    onSelected: (value) {},
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text(
                                                'Delete',
                                                style: TextFontStyle.Inter10W500
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                        fontSize: 14.sp),
                                              )),
                                          PopupMenuItem<String>(
                                              value: 'market',
                                              child: Text(
                                                'Move to Market',
                                                style: TextFontStyle.Inter10W500
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF5E5E5E),
                                                        fontSize: 14.sp),
                                              ))
                                        ])),
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
                        child: ShimmerImage(
                            imageUrl: singleCloset?.data?.image ?? '',
                            placeholder: AppImages.placeholderImage,
                            height: 180.h,
                            width: 180.w),
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
                              // * ####### title
                              UIHelper.verticalSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            return Container(
                                              height: 300.h,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 30.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Add Title',
                                                        style: TextFontStyle
                                                                .Inter10W600
                                                            .copyWith(
                                                          fontSize: 20.sp,
                                                          color:
                                                              Color(0xFF2F2F2F),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  CustomTextField(
                                                    controller:
                                                        _titleController,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          30),
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'[a-z A-Z]'))
                                                    ],
                                                    hintText: 'Casual Shirt',
                                                  ),
                                                  Spacer(),
                                                  CustomButton(
                                                      name: 'Save',
                                                      textStyle: TextFontStyle
                                                              .Inter10W600
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius: 100,
                                                      onCallBack: () {
                                                        setState(() {
                                                          _titleController =
                                                              _titleController;
                                                          Navigator.pop(
                                                              context);
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
                                        color: singleCloset?.data?.title == null && _titleController.text.isEmpty
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 5.0,
                                        ),
                                        child: Text(
                                          _titleController.text.isEmpty ?
                                          singleCloset?.data?.title ?? 'Add' : _titleController.text.trim(),
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
                              // * ####### Category

                              UIHelper.verticalSpace(16.h),
                              Divider(
                                color: AppColor.cE8E8E8,
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Category',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                                    horizontal: 20.w,
                                                    vertical: 30.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.r),
                                                    topRight:
                                                        Radius.circular(20.r),
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
                                                              color: Color(
                                                                  0xFF2F2F2F),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Categories',
                                                          style: TextFontStyle
                                                                  .Inter10W600
                                                              .copyWith(
                                                            fontSize: 20.sp,
                                                            color: Color(
                                                                0xFF2F2F2F),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          icon: Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              size: 25.sp),
                                                        ),
                                                      ],
                                                    ),

                                                    UIHelper.verticalSpace(
                                                        16.h),

                                                    // Search Field
                                                    CustomTextField(
                                                      controller:
                                                          _searchController,
                                                      fieldColor:
                                                          Colors.transparent,
                                                      borderColor: Colors.grey,
                                                      height: 50.h,
                                                      leftIcon:
                                                          AppIcons.searchIcon,
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
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                        : Wrap(
                                                            spacing: 8,
                                                            runSpacing: 8,
                                                            children:
                                                                _selectedCategories
                                                                    .asMap()
                                                                    .entries
                                                                    .map(
                                                                        (entry) {
                                                              final index =
                                                                  entry.key;
                                                              final item =
                                                                  entry.value;
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            8),
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
                                                                child: Text(item[
                                                                    'title']),
                                                              );
                                                            }).toList(),
                                                          ),

                                                    _selectedCategories
                                                            .isNotEmpty
                                                        ? UIHelper
                                                            .verticalSpaceSmall
                                                        : SizedBox.shrink(),

                                                    // Category List
                                                    _liatOfCategories.isEmpty
                                                        ? Center(
                                                            child: Text(
                                                                'No category found'))
                                                        : SizedBox(
                                                            height: 250.h,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  _liatOfCategories
                                                                          .first
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                final category =
                                                                    _liatOfCategories
                                                                            .first
                                                                            .data?[
                                                                        index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    setModalState(
                                                                        () {
                                                                      if (category !=
                                                                          null) {
                                                                        final alreadyExists =
                                                                            _selectedCategories.any(
                                                                          (item) =>
                                                                              item['id'] ==
                                                                              category.id,
                                                                        );
                                                                        if (!alreadyExists &&
                                                                            _selectedCategories.length <
                                                                                5) {
                                                                          _selectedCategories
                                                                              .add({
                                                                            "id":
                                                                                category.id,
                                                                            "title":
                                                                                category.title,
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
                                                                          color:
                                                                              Color(0xFF757575),
                                                                          fontSize:
                                                                              16.sp,
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            1,
                                                                        color: Color(
                                                                            0xFF757575),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                    Spacer(),
                                                    CustomButton(
                                                        name: "Save",
                                                        color: AppColor.cD5E7B0,
                                                        borderRadius: 100.r,
                                                        textStyle: TextFontStyle
                                                                .Inter10W600
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.sp),
                                                        onCallBack: () {
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        context: context)
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: _selectedCategories.isEmpty && singleCloset?.data?.categories == null
                                          ? 200.h
                                          : 250.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedCategories.isNotEmpty || singleCloset?.data?.categories != null
                                            ? AppColor.cD5E7B0
                                            : Color(0xFFF0F0F0),
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: _selectedCategories.isNotEmpty
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 175.w,
                                                  child: Text(
                                                    _selectedCategories
                                                        .map((item) =>
                                                            item['title'])
                                                        .join(", "),
                                                    style: TextFontStyle
                                                        .textStyle12w400NunitoSans
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      color: AppColor.c000000,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    AppIcons.arrowNext)
                                              ],
                                            )
                                          : singleCloset?.data?.categories != null 
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 175.w,
                                                  child: Text(
                                                    singleCloset!.data!.categories!
                                                        .map((item) =>
                                                            item.title)
                                                        .join(", "),
                                                    style: TextFontStyle
                                                        .textStyle12w400NunitoSans
                                                        .copyWith(
                                                      fontSize: 16.sp,
                                                      color: AppColor.c000000,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    AppIcons.arrowNext)
                                              ],
                                            ) :
                                          Row(
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
                                                SvgPicture.asset(
                                                    AppIcons.arrowNext),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),

                              // * #######################
                              // * ####### Occasion
                              UIHelper.verticalSpace(16.h),
                              Divider(
                                color: AppColor.cE8E8E8,
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Occasion',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            return Container(
                                              height: 300.h,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 30.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
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
                                                                .Inter10W600
                                                            .copyWith(
                                                          fontSize: 20.sp,
                                                          color:
                                                              Color(0xFF2F2F2F),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  CustomTextField(
                                                    controller:
                                                        _occationContriller,
                                                    hintText:
                                                        'Weading/ Birthday/ party',
                                                  ),
                                                  Spacer(),
                                                  CustomButton(
                                                      name: 'Save',
                                                      textStyle: TextFontStyle
                                                              .Inter10W600
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius: 100,
                                                      onCallBack: () {
                                                        setState(() {
                                                          _occationContriller =
                                                              _occationContriller;
                                                          Navigator.pop(
                                                              context);
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
                                        color: _occationContriller.text.isEmpty && singleCloset?.data?.occasion == null  
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 5.0,
                                        ),
                                        child: Text(
                                          _occationContriller.text.isEmpty
                                              ? singleCloset?.data?.occasion ?? 'Add'
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Brand',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            return Container(
                                              width: double.infinity,
                                              height: 300.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 30.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
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
                                                                .Inter10W600
                                                            .copyWith(
                                                          fontSize: 20.sp,
                                                          color:
                                                              Color(0xFF2F2F2F),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  CustomTextField(
                                                    controller:
                                                        _brandController,
                                                    hintText:
                                                        'Easy/ Denim/ Twelve',
                                                  ),
                                                  Spacer(),
                                                  CustomButton(
                                                      name: 'Save',
                                                      textStyle: TextFontStyle
                                                              .Inter10W600
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius: 100,
                                                      onCallBack: () {
                                                        setState(() {
                                                          _brandController =
                                                              _brandController;
                                                          Navigator.pop(
                                                              context);
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
                                        color: _brandController.text.isEmpty && singleCloset?.data?.brand == null
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 5.0,
                                        ),
                                        child: Text(
                                          _brandController.text.isEmpty
                                              ? singleCloset?.data?.brand ?? 'Add'
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Color',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                                height: 525.h,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 30.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.r),
                                                    topRight:
                                                        Radius.circular(20.r),
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
                                                                _colorList
                                                                    .clear());
                                                            _colorController
                                                                .clear();
                                                          },
                                                          child: Text(
                                                            'Reset',
                                                            style: TextFontStyle
                                                                .inter10W400
                                                                .copyWith(
                                                              fontSize: 16.sp,
                                                              color: Color(
                                                                  0xFF2F2F2F),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Add Colors',
                                                          style: TextFontStyle
                                                                  .Inter10W600
                                                              .copyWith(
                                                            fontSize: 20.sp,
                                                            color: Color(
                                                                0xFF2F2F2F),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          icon: Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              size: 25.sp),
                                                        ),
                                                      ],
                                                    ),

                                                    UIHelper.verticalSpace(
                                                        16.h),

                                                    // Search Field
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                _colorController,
                                                            fieldColor: Colors
                                                                .transparent,
                                                            borderColor:
                                                                Colors.grey,
                                                            height: 50.h,
                                                            readOnly: _colorList
                                                                        .length ==
                                                                    5
                                                                ? true
                                                                : false,
                                                            hintText:
                                                                'Red/ Green/ Blue',
                                                          ),
                                                        ),
                                                        UIHelper
                                                            .horizontalSpaceSmall,
                                                        GestureDetector(
                                                          onTap: () {
                                                            setModalState(() {
                                                              if (_colorController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                  _colorController
                                                                          .text
                                                                          .length >
                                                                      2) {
                                                                final alreadyExists =
                                                                    _colorList.any((item) =>
                                                                        item ==
                                                                        _colorController
                                                                            .text
                                                                            .trim());

                                                                if (!alreadyExists &&
                                                                    _colorList
                                                                            .length <
                                                                        5) {
                                                                  setState(() {
                                                                    _colorList.add(
                                                                        _colorController
                                                                            .text
                                                                            .trim());
                                                                  });
                                                                }
                                                                setState(() {
                                                                  _colorController
                                                                      .clear();
                                                                });
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w,
                                                                    vertical:
                                                                        8.h),
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .cD5E7B0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.r)),
                                                            child: Text(
                                                              'Add',
                                                              style: TextFontStyle
                                                                      .Inter10W600
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp),
                                                            ),
                                                          ),
                                                        )
                                                      ],
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
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                        : Wrap(
                                                            spacing: 8,
                                                            runSpacing: 8,
                                                            children: _colorList
                                                                .asMap()
                                                                .entries
                                                                .map((entry) {
                                                              final index =
                                                                  entry.key;
                                                              final item =
                                                                  entry.value;
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            8),
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
                                                                child:
                                                                    Text(item),
                                                              );
                                                            }).toList(),
                                                          ),
                                                    Spacer(),
                                                    CustomButton(
                                                        name: 'Save',
                                                        onCallBack: () {
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        color: AppColor.cD5E7B0,
                                                        borderRadius: 100,
                                                        textStyle: TextFontStyle
                                                                .Inter10W600
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.sp),
                                                        context: context)
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: _colorList.isEmpty && singleCloset?.data?.color == null ? 150.w : 220.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _colorList.isNotEmpty || singleCloset?.data?.color != null
                                            ? AppColor.cD5E7B0
                                            : Color(0xFFF0F0F0),
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: _colorList.isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3),
                                              decoration: BoxDecoration(
                                                color: AppColor.cD5E7B0,
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 168.w,
                                                    child: Text(
                                                      _colorList
                                                          .take(5)
                                                          .join(", "),
                                                      style: TextFontStyle
                                                          .textStyle12w400NunitoSans
                                                          .copyWith(
                                                        fontSize: 16.sp,
                                                        color: AppColor.c000000,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                      AppIcons.arrowNext)
                                                ],
                                              ),
                                            )
                                          : singleCloset?.data?.color != null 
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3),
                                              decoration: BoxDecoration(
                                                color: AppColor.cD5E7B0,
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 168.w,
                                                    child: Text(
                                                      singleCloset!.data!.color!
                                                          .take(5)
                                                          .join(", "),
                                                      style: TextFontStyle
                                                          .textStyle12w400NunitoSans
                                                          .copyWith(
                                                        fontSize: 16.sp,
                                                        color: AppColor.c000000,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                      AppIcons.arrowNext)
                                                ],
                                              ),
                                            ) :
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Add Colors',
                                                  style: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    fontSize: 16.sp,
                                                    color: AppColor.c000000,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    AppIcons.arrowNext)
                                              ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Material',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  GestureDetector(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        decoration: BoxDecoration(
                                          color: selectedMaterials == null && singleCloset?.data?.material == null
                                              ? Color(0xFFF0F0F0)
                                              : AppColor.cD5E7B0,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                isExpanded: false,
                                                value: selectedMaterials ?? singleCloset?.data?.material?.id?.toString(),
                                                hint: Text(
                                                  'Select Material',
                                                  style: TextFontStyle
                                                      .inter10W400
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 16.sp),
                                                ),
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                style: TextFontStyle
                                                    .textStyle12w400NunitoSans
                                                    .copyWith(
                                                  fontSize: 16.sp,
                                                  color: AppColor.c000000,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                dropdownColor: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                items: (_materialList
                                                            .isNotEmpty &&
                                                        _materialList.first
                                                            .data!.isNotEmpty)
                                                    ? _materialList.first.data!
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                        return DropdownMenuItem<
                                                                String>(
                                                            value: item.id
                                                                .toString(),
                                                            child: Text(
                                                              item.name ?? '',
                                                              style: TextFontStyle
                                                                  .inter10W400
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp),
                                                            ));
                                                      }).toList()
                                                    : [],
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedMaterials = value;
                                                  });
                                                }))),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pattern',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            return Container(
                                              width: double.infinity,
                                              height: 300.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 30.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Add Pattern',
                                                        style: TextFontStyle
                                                                .Inter10W600
                                                            .copyWith(
                                                          fontSize: 20.sp,
                                                          color:
                                                              Color(0xFF2F2F2F),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  CustomTextField(
                                                    controller:
                                                        _patternController,
                                                    hintText:
                                                        'Striped/ Checked/ Plain',
                                                  ),
                                                  Spacer(),
                                                  CustomButton(
                                                      name: 'Save',
                                                      textStyle: TextFontStyle
                                                              .Inter10W600
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius: 100,
                                                      onCallBack: () {
                                                        setState(() {
                                                          _patternController =
                                                              _patternController;
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      context: context)
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _patternController.text.isEmpty && singleCloset?.data?.pattern == null
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Text(
                                        _patternController.text.isEmpty
                                            ? singleCloset?.data?.pattern ?? 'Add'
                                            : _patternController.text,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Visibility',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                        value: changeVisibility ? selectedVisibility : singleCloset?.data?.visibility,
                                        icon: Icon(Icons.arrow_drop_down),
                                        style: TextFontStyle
                                            .textStyle12w400NunitoSans
                                            .copyWith(
                                          fontSize: 16.sp,
                                          color: AppColor.c000000,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        dropdownColor: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        items: visibilityOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            changeVisibility = true;
                                            selectedVisibility = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // * #######################
                              // * ####### Purchase Date
                              UIHelper.verticalSpace(16.h),
                              Divider(
                                color: AppColor.cE8E8E8,
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Purchased Date',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: purchasedDate == null && singleCloset?.data?.purchasedDate == null
                                          ? Color(0xFFF0F0F0)
                                          : AppColor.cD5E7B0,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 5.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final pickedDate =
                                              await showDatePicker(
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
                                          purchasedDate == null
                                              ? singleCloset?.data?.purchasedDate != null ? DateFormat("dd MMM yyyy").format(DateFormat("dd/MM/yy").parse(singleCloset!.data!.purchasedDate!)) : 'Select date'
                                              : DateFormat('dd MMM yyyy')
                                                  .format(purchasedDate!),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Size',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            borderRadius:
                                                BorderRadius.circular(20.r),
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
                              // * #######################
                              // * ####### Price
                              UIHelper.verticalSpace(16.h),
                              Divider(
                                color: AppColor.cE8E8E8,
                              ),
                              UIHelper.verticalSpace(16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
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
                                            return Container(
                                              width: double.infinity,
                                              height: 300.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 30.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Add Price',
                                                        style: TextFontStyle
                                                                .Inter10W600
                                                            .copyWith(
                                                          fontSize: 20.sp,
                                                          color:
                                                              Color(0xFF2F2F2F),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  CustomTextField(
                                                      controller:
                                                          _priceController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9.]')),
                                                        LengthLimitingTextInputFormatter(
                                                            15)
                                                      ],
                                                      hintText: '120.58',
                                                      leftIcon:
                                                          AppIcons.dollar),
                                                  Spacer(),
                                                  CustomButton(
                                                      name: 'Save',
                                                      textStyle: TextFontStyle
                                                              .Inter10W600
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius: 100,
                                                      onCallBack: () {
                                                        setState(() {
                                                          _priceController =
                                                              _priceController;
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      context: context)
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _priceController.text.isEmpty && singleCloset?.data?.price == null
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Text(
                                        _priceController.text.isEmpty
                                            ? singleCloset?.data?.price == null ? 'Add' : '\$${singleCloset?.data?.price}'
                                            : '\$${_priceController.text}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Season',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.c000000,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedSeason == null && singleCloset?.data?.season == null
                                            ? Color(0xFFF0F0F0)
                                            : AppColor.cD5E7B0,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                              value: changeSeason ? selectedSeason : singleCloset?.data?.season,
                                              hint: Text(
                                                'Select Season',
                                                style: TextFontStyle.inter10W400
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 16.sp),
                                              ),
                                              icon: Icon(Icons.arrow_drop_down),
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                fontSize: 16.sp,
                                                color: AppColor.c000000,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              items: seasonOption.map((season) {
                                                return DropdownMenuItem(
                                                    value: season,
                                                    child: Text(season));
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  changeSeason = true;
                                                  selectedSeason = newValue;
                                                });
                                              }))),
                                ],
                              ),
                              UIHelper.verticalSpace(16.h),
                            ],
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      CustomButton(
                          name: 'Add Closet',
                          onCallBack: () async {
                            // (_titleController.text.isEmpty ||
                            //         _selectedCategories.isEmpty ||
                            //         _colorList.isEmpty ||
                            //         selectedMaterials == null ||
                            //         _priceController.text.isEmpty)
                            //     ? showSnackBarMessage(
                            //         'Title, Categoruy, Color, Material & Pattern is Required')
                            //     : postAddCloset(PostAddClosetModel(
                            //         title: _titleController.text.trim(),
                            //         categories: _selectedCategories,
                            //         occation: _occationContriller.text.trim(),
                            //         brand: _brandController.text.trim(),
                            //         colors: _colorList,
                            //         materialId:
                            //             int.tryParse(selectedMaterials ?? "") ?? 0,
                            //         pattern: _patternController.text.trim(),
                            //         visibility: selectedVisibility,
                            //         purchasedDate: purchasedDate,
                            //         size: selectedSize,
                            //         price: _priceController.text.trim(),
                            //         season: selectedSeason,
                            //         image: widget.imageBytes
                            // )
                            // );
                          },
                          color: AppColor.cD5E7B0,
                          textStyle: TextFontStyle.Inter10W600.copyWith(
                              color: Colors.black, fontSize: 16.sp),
                          borderRadius: 100.r,
                          context: context),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
