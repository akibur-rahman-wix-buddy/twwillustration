import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/home/widgets/outfit_dairy_card.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/home_screen_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetProfileDataModel? profileData;
  bool isLoading = false;

  String? selectedOccasion;
  String? selectedMood;
  String? selectedColor;

  final List<String> occasions = ["Birthday", "Wedding", "Party"];
  final List<String> moods = ["Happy", "Sad", "Excited"];
  final List<String> colors = ["Red", "Green", "Blue"];

  Future<void> fetchProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await getProfileRxObj.getProfileRx();

      if (success) {
        getProfileRxObj.getProfileData.listen((profile) {
          setState(() {
            profileData = profile;
          });
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print('$error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? HomeScreenShimmer()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          UIHelper.verticalSpace(60.h),
                          // * App Bar Part
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    NavigationService.navigateTo(
                                        Routes.settingScreen);
                                  },
                                  child: ShimmerClipOvalWidget(
                                    height: 40.h,
                                    weight: 40.h,
                                    networkImageLink:
                                        profileData?.data?.avatar ?? '',
                                  )),
                              UIHelper.horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, ${profileData?.data?.firstName ?? ''}!',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  Text(
                                    'Dress what feels right today',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              SvgPicture.asset(AppIcons.notification),
                            ],
                          ),
                          UIHelper.verticalSpace(30.h),

                          // * Weather Part
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.sp),
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
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'New York City\n',
                                    style: TextStyle(
                                      color: const Color(0xFF2F2F2F),
                                      fontSize: 20.sp,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 1.32,
                                      letterSpacing: -0.20,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Tue, May 17',
                                    style: TextStyle(
                                      color: const Color(0xFF757575),
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.71,
                                      letterSpacing: -0.14,
                                    ),
                                  )
                                ])),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.farenheit),
                                    UIHelper.horizontalSpace(10.w),
                                    Text(
                                      '54° F',
                                      style: TextStyle(
                                        color: const Color(0xFF2F2F2F),
                                        fontSize: 20.sp,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.32,
                                        letterSpacing: -0.20,
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(15.5.w)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpace(30.h),

                          // * outfit ideas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'OutFit Ideas for Today',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor.cFFFFFF.withValues(alpha: .1),
                                  border: Border.all(
                                    color:
                                        AppColor.c000000.withValues(alpha: .1),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Text(
                                    'Generate',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(20.h),
                        ],
                      ),
                    ),

                    // * Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UIHelper.horizontalSpaceMedium,
                          Chip(
                            label: const Text("All"),
                            backgroundColor: Colors.green.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                          ),
                          UIHelper.horizontalSpaceSmall,

                          // * Occasion Dropdown
                          _buildDropdownChip(
                            title: "Occasion",
                            items: occasions,
                            selected: selectedOccasion,
                            onChanged: (value) {
                              setState(() => selectedOccasion = value);
                            },
                            color: Colors.orange.shade100,
                          ),
                          UIHelper.horizontalSpaceSmall,

                          // * Mood Dropdown
                          _buildDropdownChip(
                            title: "Mood",
                            items: moods,
                            selected: selectedMood,
                            onChanged: (value) {
                              setState(() => selectedMood = value);
                            },
                            color: Colors.yellow.shade100,
                          ),
                          UIHelper.horizontalSpaceSmall,

                          // * Color Dropdown
                          _buildDropdownChip(
                            title: "Color",
                            items: colors,
                            selected: selectedColor,
                            onChanged: (value) {
                              setState(() => selectedColor = value);
                            },
                            color: Colors.pink.shade100,
                          ),
                          UIHelper.horizontalSpaceMedium,
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(25.h),
                    // * Outfit Suggestions
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 160.w,
                                height: 220.h, // ✅ Fix height
                                child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.cFFFFFF,
                                    border: Border.all(
                                      color: AppColor.c000000
                                          .withValues(alpha: .1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIcons.styleIcon),
                                            UIHelper.horizontalSpace(8.w),
                                            Text(
                                              'Style My Own',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                color: AppColor.c000000,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        UIHelper.verticalSpaceMedium,
                                        Text(
                                            'Create your own outfit combinations with AI assistance'),
                                        const Spacer(),
                                        CustomButton(
                                          name: 'Create Outfit',
                                          onCallBack: () {},
                                          context: context,
                                          borderRadius: 48.r,
                                          color: AppColor.cE4EDC9,
                                          textStyle: TextFontStyle
                                              .textStyle12w400NunitoSans
                                              .copyWith(
                                            color: AppColor.c000000,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 160.w,
                                height: 220.h, // ✅ Same fixed height
                                child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColor.cFFFFFF,
                                    border: Border.all(
                                      color: AppColor.c000000
                                          .withValues(alpha: .1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIcons.statsIcon),
                                            UIHelper.horizontalSpace(8.w),
                                            Text(
                                              'Quick Stats',
                                              style: TextFontStyle
                                                  .textStyle12w400NunitoSans
                                                  .copyWith(
                                                color: AppColor.c000000,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        UIHelper.verticalSpaceMedium,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '42',
                                                  style: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    color: AppColor.c000000,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  'Items',
                                                  style: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    color: AppColor.c000000,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '68%',
                                                  style: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    color: AppColor.c000000,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  'Usage',
                                                  style: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    color: AppColor.c000000,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Spacer(), // ✅ button নিচে যাবে
                                        CustomButton(
                                          name: 'View Details',
                                          onCallBack: () {
                                            NavigationService.navigateTo(
                                              Routes.quickStatsScreen,
                                            );
                                          },
                                          context: context,
                                          borderRadius: 48.r,
                                          borderColor: AppColor.c000000,
                                          color: AppColor.cFFFFFF
                                              .withValues(alpha: .1),
                                          textStyle: TextFontStyle
                                              .textStyle12w400NunitoSans
                                              .copyWith(
                                            color: AppColor.c000000,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(25.h),
                          // * outfit ideas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Outfit Diary',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  NavigationService.navigateTo(Routes.aiScreen);
                                },
                                child: Text(
                                  'View all',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutfitDairyCard(
                                  imagePath: null,
                                  day: 'Yesterday',
                                  onAdd: () {}),
                              OutfitDairyCard(
                                  imagePath: null, day: 'Today', onAdd: () {}),
                              OutfitDairyCard(
                                  imagePath: null,
                                  day: 'Tomorrow',
                                  onAdd: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpaceMedium
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildDropdownChip({
    required String title,
    required List<String> items,
    required String? selected,
    required Function(String?) onChanged,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: .1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          hint: Text(
            title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.c000000,
            ),
          ),
          icon: SvgPicture.asset(
            AppIcons.dropDown,
          ),
          onChanged: onChanged,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
