// ignore_for_file: unused_field, library_private_types_in_public_api, use_super_parameters, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final List<String> categories = [
    "Casual",
    "Formal",
    "Sporty",
    "Streetwear",
    "Elegant",
    "Boho",
  ];

  final List<String> mainStyle = [
    "Casual",
    "Formal",
    "Active",
    "Night Out",
    "Smart Casual",
  ];

  List<String> selectedItems = [];
  List<String> selectedMainItems = [];

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
                // * App Bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(AppIcons.backIcon)),
                    UIHelper.horizontalSpace(100.w),
                    Text(
                      'Drobie AI',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,

                // * drobie ai container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.04),
                      end: Alignment(1.00, 1.00),
                      colors: [
                        const Color(0x4C81CA17),
                        const Color(0x60E6F0EA)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.drobieImage),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            'Drobie',
                            style: TextStyle(
                              color: const Color(0xFF2F2F2F),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.30,
                              letterSpacing: -0.18,
                            ),
                          ),
                          Text(
                            'Online',
                            style: TextStyle(
                              color: const Color(0xFF757575),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.30,
                              letterSpacing: -0.18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Style Pofile',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.c000000,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favourite Color',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Select your favourite color",
                  controller: TextEditingController(),
                  dropdownItems: ['Warm', 'Cold', 'Natural', 'Dark', 'Bright'],
                  onChanged: (value) {
                    print("User selected: $value"); // এখানে print হবে
                  },
                ),

                UIHelper.verticalSpace(20.h),

                // * Style Preference
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: categories.map((item) {
                    final isSelected = selectedItems.contains(item);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedItems.remove(item);
                          } else {
                            selectedItems.add(item);
                          }
                          print(selectedItems); // selected list print হবে
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppIcons.shirt,
                              width: 16,
                              height: 16,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item,
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                UIHelper.verticalSpace(10.h),

                // * Hair Color setup
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hair Color',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Select your Hair color",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Black',
                    'White',
                    'Brown',
                  ],
                  onChanged: (value) {
                    print("User color selected: $value"); // এখানে print হবে
                  },
                ),

                UIHelper.verticalSpace(20.h),

                // * Main Style Preference
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Main Style',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: mainStyle.map((item) {
                    final isSelected = selectedMainItems.contains(item);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedMainItems.remove(item);
                          } else {
                            selectedMainItems.add(item);
                          }

                          // এখানে কাস্টম ফরম্যাটে প্রিন্ট হবে
                          final formatted =
                              "[{${selectedMainItems.join(', ')}}]";
                          print(formatted);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppIcons.shirt,
                              width: 16,
                              height: 16,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item,
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                UIHelper.verticalSpace(10.h),

                // * Body Shape
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Body Shape',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Select your body shape",
                  controller: TextEditingController(),
                  dropdownItems: [
                    'Slim',
                    'Athletic',
                    'Curvy',
                  ],
                  onChanged: (value) {
                    print(
                      "User body shape selected: $value",
                    ); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(20.h),

                // * Budget Range
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Budget Range',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                CustomDropDown(
                  hintText: "Select your budget range",
                  controller: TextEditingController(),
                  dropdownItems: [
                    '\$100 - \$5000',
                    '\$5000 - \$10000',
                    '\$10000 - \$20000',
                  ],
                  onChanged: (value) {
                    print(
                      "User budget range selected: $value",
                    ); // এখানে print হবে
                  },
                ),
                UIHelper.verticalSpace(25.h),

                // * custom button
                CustomButton(
                  name: 'Save Preference',
                  onCallBack: () {},
                  context: context,
                  color: AppColor.cD5E7B0,
                  borderColor: AppColor.cD5E7B0,
                  borderRadius: 30,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(25.h),

                // * custom button
                CustomButton(
                  name: 'Generate Outfit Suggestions',
                  onCallBack: () {},
                  context: context,
                  color: AppColor.cFFFFFF,
                  borderColor: AppColor.cD5E7B0,
                  borderRadius: 30,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                UIHelper.verticalSpace(20.h),
                // * AI Suggestions
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AI Suggestions',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.c000000,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                // * AI Suggestions Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColor.cE8E8E8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            UIHelper.verticalSpace(10.h),
                            Image.asset(
                              AppImages.dress,
                              width: 70.w,
                              height: 130.h,
                              fit: BoxFit.fill,
                            ),
                            UIHelper.verticalSpace(10.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Suggestion 1',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Urban fashion inspiration',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColor.cE8E8E8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            UIHelper.verticalSpace(10.h),
                            Image.asset(
                              AppImages.dress,
                              width: 70.w,
                              height: 130.h,
                              fit: BoxFit.fill,
                            ),
                            UIHelper.verticalSpace(10.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Suggestion 1',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Urban fashion inspiration',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quick Action',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.cA3A3A3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                CustomTextField(
                  hintText: 'Find an outfit for...',
                  controller: TextEditingController(),
                ),
                UIHelper.verticalSpace(14.h),
                // * custom button
                CustomButton(
                  name: 'Ask AI Assistant',
                  onCallBack: () {
                    NavigationService.navigateTo(Routes.outfitSuggestionScreen);
                  },
                  context: context,
                  color: AppColor.cD5E7B0,
                  borderColor: AppColor.cD5E7B0,
                  borderRadius: 30,
                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                        color: AppColor.c000000,
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
