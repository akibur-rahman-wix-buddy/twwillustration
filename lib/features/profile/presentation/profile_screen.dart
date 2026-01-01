import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
import 'package:twwillustration/features/profile/model/get_single_outfit_data_model.dart' hide Categories;
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/colthes_shimmer.dart';
import 'package:twwillustration/shimmer_widget/profile_screen_shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetProfileDataModel? profileData;
  int follower = 0;
  int following = 0;

  int selectedIndex = 0;
  int selectedCategoryIndex = 0;
  int selectedOutfitIndex = 0;
  int selectedOutfitCategoryIndex = 0;
  final double value = 0.5;
  bool isLoading = false;
  bool isClothesLoading = false;

  List<GetCategoriesDataModel> _categories = [];
  final List<String> outfitcategories = [
    'All',
    'Casual',
    'Work',
    'Formal',
    'Sport'
  ];

  List<GetSingleCategoryDataModel> _clothesData = [];
  // * outfit
  List<GetSingleOutfitDataModel> _outfitData = [];

  final List<TabItem> tabs = [
    TabItem(
      icon: SvgPicture.asset(AppIcons.clothSvg),
      label: 'Clothes',
      count: 12,
    ),
    TabItem(
      icon: SvgPicture.asset(AppIcons.outfitSvg),
      label: 'Outfits',
      count: null,
    ),
    TabItem(
      icon: SvgPicture.asset(AppIcons.treeSvg),
      label: 'My Tree',
      count: null,
    ),
  ];

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
          fetchFollower();
          fetchFollowing();
          fetchCategories();
          fetchSingleCategory(profileData?.data?.id ?? 0, null);
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
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> fetchFollower() async {
    try {
      if (profileData?.data?.id == null) {
        return;
      }
      int userId = profileData!.data!.id!;

      bool success = await postFollowerRxObj.postFollowerRx(userId);

      if (success) {
        postFollowerRxObj.getFollowerData.listen((result) {
          setState(() {
            follower = (result["data"] as List).length;
          });
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchFollowing() async {
    try {
      if (profileData?.data?.id == null) {
        return;
      }
      int userId = profileData!.data!.id!;

      bool success = await postFollowingRxObj.postFollowingRx(userId);

      if (success) {
        postFollowingRxObj.getFollowingData.listen((result) {
          setState(() {
            following = (result["data"] as List).length;
          });
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchCategories() async {
    try {
      bool success = await getCategoriesRxObj.getCategoriesRx();

      if (success) {
        getCategoriesRxObj.getCategoriesData.listen((categories) {
          setState(() {
            _categories = [categories];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSingleCategory(int userID, int? productId) async {
    try {
      setState(() {
        isClothesLoading = true;
      });
      bool success =
          await getSingleCategoryRxObj.getSingleCategoryRx(userID, productId);

      if (success) {
        getSingleCategoryRxObj.getSingleCategoryData.listen((clothes) {
          setState(() {
            _clothesData = [clothes];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isClothesLoading = false;
      });
    }
  }

  Future<void> fetchSingleOutfit(int userID, String? category) async {
    try {
      setState(() {
        isClothesLoading = true;
      });
      bool success =
          await getSingleOutfitRxObj.getSingleOutfitRx(userID, category);

      if (success) {
        getSingleOutfitRxObj.getSingleOutfitData.listen((outfit) {
          setState(() {
            _outfitData = [outfit];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isClothesLoading = false;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            SizedBox(
              width: double.infinity,
              height: 350,
              child: isLoading
                  ? ShimmerProfileScreen()
                  : Stack(
                      children: [
                        // Background Image
                        ClipRRect(
                          child: Image.asset(
                            AppImages.profileCard,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        // Back Button
                        Positioned(
                          top: 70,
                          left: 16,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(AppIcons.backIcon),
                          ),
                        ),

                        // Share Button
                        Positioned(
                          top: 70,
                          right: 16,
                          child: GestureDetector(
                            onTap: () {
                              // Share functionality
                            },
                            child: SvgPicture.asset(AppIcons.shareIcon),
                          ),
                        ),

                        // Profile Picture
                        Positioned(
                          top: 130,
                          left: 16,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: ShimmerClipOvalWidget(
                                      height: 70,
                                      weight: 70,
                                      networkImageLink:
                                          profileData?.data?.avatar ?? "",
                                    )),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Add profile picture functionality
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // User Info
                        Positioned(
                          top: 140,
                          left: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profileData?.data!.firstName}.${profileData?.data!.lastName}',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'ID: ${profileData?.data?.uuid ?? ""}',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bio Section
                        Positioned(
                          top: 220,
                          left: 16,
                          child: SizedBox(
                            width: 250.w,
                            child: Text(
                              profileData?.data?.bio ?? '',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),

                        // Stats Section
                        Positioned(
                          top: 290,
                          left: 16,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  NavigationService.navigateToWithArgs(
                                      Routes.followersScreen,
                                      {'userId': profileData!.data!.id});
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      follower.toString(),
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 50),
                              GestureDetector(
                                onTap: () {
                                  NavigationService.navigateToWithArgs(
                                      Routes.followingScreen,
                                      {'userId': profileData!.data!.id});
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      following.toString(),
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: TextFontStyle
                                          .textStyle12w400NunitoSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Edit Profile Button
                        Positioned(
                          top: 290,
                          right: 20,
                          child: CustomButton(
                            name: 'Edit Profile',
                            onCallBack: () {
                              NavigationService.navigateTo(
                                  Routes.editProfileScreen);
                            },
                            context: context,
                            color: AppColor.cE4EDC9,
                            textStyle: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                            minWidth: 120.w,
                            borderRadius: 37,
                            borderColor: AppColor.c000000,
                            height: 36.h,
                          ),
                        ),
                      ],
                    ),
            ),

            // * Tab Navigation
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .5),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: tabs.asMap().entries.map((entry) {
                      int index = entry.key;
                      TabItem tab = entry.value;
                      bool isSelected = selectedIndex == index;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            setState(() {
                              selectedIndex = index;
                            });
                            if(selectedIndex == 0 || selectedIndex == 1) fetchCategories();
                            if(selectedIndex == 0) fetchSingleCategory(profileData!.data!.id!, 1);
                            if(selectedIndex == 1) fetchSingleOutfit(profileData!.data!.id!, 'All');
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: AppColor.cFFFFFF,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.cE4EDC9
                                    : AppColor.cFFFFFF,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  tab.icon,
                                  SizedBox(width: 8),
                                  Text(
                                    tab.label,
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: isSelected
                                          ? Colors.black87
                                          : Colors.grey[600],
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
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

            // Content Area
            Container(
              height: MediaQuery.of(context).size.height - 450,
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context){
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r)
                  ),
                  color: AppColor.cFFFFFF
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Color(0xFF757575)
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => NavigationService.navigateTo(Routes.addClosetScreen),
                          child: Container(
                            height: 168.h,
                            width: 164.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(width: 1, color: Colors.grey)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.addClosetImage, height: 48.h, width: 48.h,),
                                UIHelper.verticalSpace(16.h),
                                Text(
                                  'Add Closet',
                                  style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 168.h,
                          width: 164.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(width: 1, color: Colors.grey)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.addOutfitImage, height: 48.h, width: 48.h,),
                              UIHelper.verticalSpace(16.h),
                              Text(
                                'Add Outfit',
                                style: TextFontStyle.textStyle16w400c5C5C5C.copyWith(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(50.h)
                  ],
                ),
              );
            }
            );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedIndex) {
      case 0:
        return _buildClothesContent();
      case 1:
        return _buildOutfitsContent();
      case 2:
        return _buildMyTreeContent();
      default:
        return Container();
    }
  }

  // * Clothes Tab Content
  Widget _buildClothesContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _categories.isEmpty || _categories.first.data == null
                ? SizedBox.shrink()
                : SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _categories.first.data?.length,
                        itemBuilder: (context, index) {
                          final button = _categories.first.data?[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                              fetchSingleCategory(
                                  profileData?.data?.id ?? 0, button?.id);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedCategoryIndex == index
                                    ? _getCategoryColor(index)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                button?.title ?? '',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  color: (selectedCategoryIndex == index)
                                      ? Colors.black87
                                      : Colors.grey[600],
                                  fontWeight: (selectedCategoryIndex == index)
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            UIHelper.verticalSpaceMedium,

            // * Clothes Grid

            isClothesLoading || isLoading
                ? ClothesGridShimmer()
                : _clothesData.first.data == [] ||
                        _clothesData.first.data!.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            UIHelper.verticalSpace(50),
                            Lottie.asset(AppLotties.noDataFound)
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: _clothesData.first.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = _clothesData.first.data?[index];
                            return _buildClothesCard(
                              ClothesItem(
                                id: item?.id,
                                image: item?.image,
                                categories: item?.categories,
                              ),
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }

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

  Widget _buildClothesCard(ClothesItem item) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateToWithArgs(Routes.closetDetailsScreen, {'closetId' : item.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .5),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                              Routes.closetDetailsScreen,
                            );
                          },
                          child: ShimmerImage(
                              imageUrl: item.image ?? '',
                              placeholder: item.categories?.first.title ?? '',
                              height: 80.h,
                              width: 80.w)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // * ################################################################
  // * ################################################################
  // * ####################### -- outfit -- ###########################
  // * ################################################################
  // * ################################################################
  Widget _buildOutfitsContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _categories.isEmpty || _categories.first.data == null
                ? SizedBox.shrink()
                : SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _categories.first.data?.length,
                        itemBuilder: (context, index) {
                          final button = _categories.first.data?[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOutfitIndex = index;
                              });
                              fetchSingleOutfit(profileData?.data?.id ?? 0, button?.title);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedOutfitIndex == index
                                    ? _getCategoryColor(index)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                button?.title ?? '',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  color: (selectedOutfitIndex == index)
                                      ? Colors.black87
                                      : Colors.grey[600],
                                  fontWeight: (selectedOutfitIndex == index)
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            UIHelper.verticalSpaceMedium,
            isClothesLoading || isLoading
                  ? ClothesGridShimmer()
                  : _clothesData.first.data == [] ||
                          _clothesData.first.data!.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              UIHelper.verticalSpace(50),
                              Lottie.asset(AppLotties.noDataFound)
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GridView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: _clothesData.first.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = _clothesData.first.data?[index];
                              return _buildClothesCard(
                                ClothesItem(
                                  id: item?.id,
                                  image: item?.image,
                                  categories: item?.categories,
                                ),
                              );
                            },
                          ),
                        )
          ],
        ),
      ),
    );
  }

  Color _getOutfitCategoryColor(int index) {
    final colors = [
      Color(0xFFB8E6B8), // All - Light Green
      Color(0xFFF5E6A3), // Casual - Light Yellow
      Color(0xFFFFB3B3), // Work - Light Orange
      Color(0xFFFFB3D9), // Formal - Light Pink
      Color(0xFFB3D9FF), // Sport - Light Blue
    ];
    return colors[index % colors.length];
  }

  Widget _buildOutfitCard(OutfitItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.fullDress,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // * ################################################################
  // * ################################################################
  // * ################### -- My Tree -- ##############################
  // * ################################################################
  // * ################################################################
  Widget _buildMyTreeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.treeSvg,
                height: 24,
              ),
              UIHelper.horizontalSpaceSmall,
              Text(
                'My Tree Progress',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(10.h),
          Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .5),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.treeImage,
                    height: 80.h,
                    width: 80.w,
                  ),
                  UIHelper.verticalSpace(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.waterDropsSvg),
                        Text(
                          "Water Drops:",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "120/300",
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 16,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.cC4CABA,
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      name: 'Water the Tree',
                      onCallBack: () {},
                      context: context,
                      minWidth: double.infinity,
                      color: AppColor.cD5E7B0,
                      borderColor: AppColor.cD5E7B0,
                      textStyle:
                          TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
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

class TabItem {
  final SvgPicture icon;
  final String label;
  final int? count;

  TabItem({
    required this.icon,
    required this.label,
    this.count,
  });
}

class ClothesItem {
  int? id;
  String? image;
  List<Categories>? categories;

  ClothesItem({this.id, this.image, this.categories});
}

class OutfitItem {
  final String image;
  final String category;

  OutfitItem({
    required this.image,
    required this.category,
  });
}
