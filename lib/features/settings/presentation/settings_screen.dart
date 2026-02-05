import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/constants/app_constants.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/features/settings/widgets/profile_widgets.dart';
import 'package:twwillustration/features/settings/widgets/setting_widget.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/di.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/networks/stream_cleaner.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;
  bool profileIsLoading = false;
  bool notifactoionEnable = true;

  GetProfileDataModel? profileData;

  Future<void> fetchProfile() async {
    setState(() {
      profileIsLoading = true;
    });
    try {
      bool sucess = await getProfileRxObj.getProfileRx();
      print('Sucess >>>>>>>>>>>>>>>>>>>>>>> $sucess');

      if (sucess) {
        getProfileRxObj.getProfileData.listen((profile) {
          setState(() {
            profileData = profile;
          });
        });
        setState(() {
          profileIsLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print('$error');
    } finally {
      setState(() {
        profileIsLoading = false;
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// HEADER
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            NavigationService.goBack();
                          },
                          child: SvgPicture.asset(AppIcons.backIcon),
                        ),
                        const Spacer(),
                        Text(
                          'Settings',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColor.c000000,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),

                    UIHelper.verticalSpace(24.h),

                    /// PROFILE CARD
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.profileScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0x4C81CA17),
                              Color(0x60E6F0EA),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ShimmerClipOvalWidget(
                              height: 64.h,
                              weight: 64.h,
                              networkImageLink: profileData?.data?.avatar ?? '',
                            ),
                            UIHelper.horizontalSpace(16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profileData?.data?.firstName ?? ''} ${profileData?.data?.lastName ?? ''}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  profileData?.data?.email ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    UIHelper.verticalSpaceMedium,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColor.c000000,
                          width: 0.1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Personal Settings',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.c5A5C5F,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.tree),
                              title: 'My Tree',
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.subscription),
                              title: 'Subscription',
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.account),
                              title: 'Account Information',
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.favourite),
                              title: 'My Favourites',
                              onTap: () {NavigationService.navigateTo(Routes.wishlistScreen);},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.blockUserIcon),
                              title: 'Block User',
                              onTap: () {
                                NavigationService.navigateTo(
                                    Routes.blockUserScreen);
                              },
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.notificationIcon),
                              title: 'Notifications',
                              notificationSwitch: Switch(
                                  value: notifactoionEnable,
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey[300],
                                  activeTrackColor: Color(0xFFD5E7B0),
                                  onChanged: (value) {
                                    setState(() {
                                      notifactoionEnable = value;
                                    });
                                  }),
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.country),
                              title: 'Country',
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.language),
                              title: 'Language',
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.temp),
                              title: 'Temperature Unit',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColor.c000000,
                          width: 0.1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Customer Service',
                                style: TextFontStyle.textStyle12w400NunitoSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.c5A5C5F,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(24.h),
                            SettingsWidgets(
                              onTap: () {
                                NavigationService.navigateTo(Routes.faqScreen);
                              },
                              icons: SvgPicture.asset(AppIcons.faq),
                              title: 'FAQs',
                            ),
                            UIHelper.verticalSpace(24.h),
                            SettingsWidgets(
                              onTap: () {},
                              icons: SvgPicture.asset(AppIcons.notice),
                              title: 'Notice',
                            ),
                            UIHelper.verticalSpace(24.h),
                            SettingsWidgets(
                              onTap: () {},
                              icons: SvgPicture.asset(AppIcons.feedback),
                              title: 'Feedback',
                            ),
                          ],
                        ),
                      ),
                    ),

                    UIHelper.verticalSpaceMedium,

                    /// ACCOUNT SECTION
                    _sectionContainer(
                      title: 'Account',
                      children: [
                        SettingsWidgets(
                          icons: SvgPicture.asset(AppIcons.logout),
                          title: 'Logout',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirmation"),
                                  content:
                                      Text("Are you sure you want to log out?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _handleLogout();
                                      },
                                      child: Text(
                                        "Log out",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        UIHelper.verticalSpace(24.h),
                        SettingsWidgets(
                          icons: SvgPicture.asset(AppIcons.delete),
                          title: 'Delete Account',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// FULL SCREEN LOADER
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: .3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// LOGOUT FUNCTION
  Future<void> _handleLogout() async {
    setState(() => isLoading = true);

    try {
      final success =
          await postLogoutRxObj.logout().timeout(const Duration(seconds: 10));

      if (success) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);

        NavigationService.navigateToUntilReplacement(
          Routes.loginScreen,
        );
      } else {
        _showError('Logout failed. Please try again.');
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _sectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.c000000, width: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
              fontSize: 14.sp,
              color: AppColor.c5A5C5F,
            ),
          ),
          UIHelper.verticalSpace(24.h),
          ...children,
        ],
      ),
    );
  }
}
