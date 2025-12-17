// // ignore_for_file: camel_case_types
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/assets_helper/app_image.dart';
// import 'package:twwillustration/constants/app_constants.dart';
// import 'package:twwillustration/helpers/all_routes.dart';
// import 'package:twwillustration/helpers/di.dart';
// import 'package:twwillustration/helpers/navigation_service.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';
// import 'package:twwillustration/networks/api_acess.dart';
// import 'package:twwillustration/networks/stream_cleaner.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(
//               20,
//             ),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               NavigationService.goBack;
//                             },
//                             child: SvgPicture.asset(AppIcons.backIcon)),
//                         UIHelper.horizontalSpace(100.w),
//                         Text(
//                           'Settings',
//                           style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                             fontSize: 20.sp,
//                             color: AppColor.c000000,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ],
//                     ),
//                     UIHelper.verticalSpace(24.h),
//                     GestureDetector(
//                       onTap: () {
//                         NavigationService.navigateTo(Routes.profileScreen);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: ShapeDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment(0.00, 0.04),
//                             end: Alignment(1.00, 1.00),
//                             colors: [
//                               const Color(0x4C81CA17),
//                               const Color(0x60E6F0EA)
//                             ],
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           spacing: 16,
//                           children: [
//                             Container(
//                               width: 64,
//                               height: 64,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                     AppImages.profile,
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.61),
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               spacing: 4,
//                               children: [
//                                 Text(
//                                   'Kenneth Allen',
//                                   style: TextStyle(
//                                     color: const Color(0xFF2F2F2F),
//                                     fontSize: 16,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w500,
//                                     height: 1.30,
//                                     letterSpacing: -0.18,
//                                   ),
//                                 ),
//                                 Text(
//                                   'rodger913@aol.com',
//                                   style: TextStyle(
//                                     color: const Color(0xFF757575),
//                                     fontSize: 16,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.30,
//                                     letterSpacing: -0.18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     UIHelper.verticalSpace(24.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColor.cFFFFFF,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColor.c000000,
//                           width: 0.1,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Personal Settings',
//                                 style: TextFontStyle.textStyle12w400NunitoSans
//                                     .copyWith(
//                                   fontSize: 14.sp,
//                                   color: AppColor.c5A5C5F,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.tree),
//                               title: 'My Tree',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.subscription),
//                               title: 'Subscription',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.account),
//                               title: 'Account Information',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.favourite),
//                               title: 'My Favourites',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.notificationIcon),
//                               title: 'Notifications',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.country),
//                               title: 'Country',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.language),
//                               title: 'Language',
//                               onTap: () {},
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             profileWidgets(
//                               icon: SvgPicture.asset(AppIcons.temp),
//                               title: 'Temperature Unit',
//                               onTap: () {},
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     UIHelper.verticalSpaceMedium,
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColor.cFFFFFF,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColor.c000000,
//                           width: 0.1,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Customer Service',
//                                 style: TextFontStyle.textStyle12w400NunitoSans
//                                     .copyWith(
//                                   fontSize: 14.sp,
//                                   color: AppColor.c5A5C5F,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Manrope',
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () {

//                               },
//                               icons: SvgPicture.asset(AppIcons.faq),
//                               title: 'FAQs',
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () {

//                               },
//                               icons: SvgPicture.asset(AppIcons.notice),
//                               title: 'Notice',
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () {

//                               },
//                               icons: SvgPicture.asset(AppIcons.feedback),
//                               title: 'Feedback',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     UIHelper.verticalSpaceMedium,
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColor.cFFFFFF,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColor.c000000,
//                           width: 0.1,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Policy',
//                                 style: TextFontStyle.textStyle12w400NunitoSans
//                                     .copyWith(
//                                   fontSize: 14.sp,
//                                   color: AppColor.c5A5C5F,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Manrope',
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () {

//                               },
//                               icons: SvgPicture.asset(AppIcons.terms),
//                               title: 'Terms of Service',
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () {

//                               },
//                               icons: SvgPicture.asset(AppIcons.feedback),
//                               title: 'Privacy Policy',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     UIHelper.verticalSpaceMedium,
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColor.cFFFFFF,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColor.c000000,
//                           width: 0.1,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Account',
//                                 style: TextFontStyle.textStyle12w400NunitoSans
//                                     .copyWith(
//                                   fontSize: 14.sp,
//                                   color: AppColor.c5A5C5F,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: () async{
//                                 setState(() {
//                                   isLoading = true;
//                                 });

//                                 try{
//                                   bool success = await postLogoutRxObj.logout();
//                                   await Future.delayed(const Duration(microseconds: 300));

//                                 if(success){
//                                   totalDataClean();
//                                   appData.write(kKeyIsLoggedIn, false);

//                                   NavigationService.navigateToUntilReplacement(Routes.loginScreen);
//                                 } else{
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Logout failed. Please try again.'),
//                                       backgroundColor: Colors.red,
//                                     )
//                                     );
//                                 }
//                                 } catch(e){
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('Error : $e'),
//                                       backgroundColor: Colors.red,
//                                     )
//                                   );
//                                 } finally{
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 }
//                               },
//                               icons: SvgPicture.asset(AppIcons.logout),
//                               title: 'Logout',
//                             ),
//                             UIHelper.verticalSpace(24.h),
//                             settingsWidgets(
//                               onTap: (){},
//                               icons: SvgPicture.asset(AppIcons.delete),
//                               title: 'Delete Account',
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class settingsWidgets extends StatelessWidget {
//   final SvgPicture icons;
//   final String title;
//   final VoidCallback onTap;
//   const settingsWidgets({
//     super.key,
//     required this.icons,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           icons,
//           UIHelper.horizontalSpace(12.w),
//           Text(
//             title,
//             style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//               fontSize: 16.sp,
//               color: AppColor.c5A5C5F,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class profileWidgets extends StatelessWidget {
//   final SvgPicture icon;
//   final String title;
//   final VoidCallback? onTap;
//   const profileWidgets({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           icon,
//           UIHelper.horizontalSpace(12.w),
//           Text(
//             title,
//             style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//               fontSize: 16.sp,
//               color: AppColor.c5A5C5F,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Spacer(),
//           SvgPicture.asset(AppIcons.nextArrow),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/constants/app_constants.dart';
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
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.profile),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            UIHelper.horizontalSpace(16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Kenneth Allen',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'rodger913@aol.com',
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
                              onTap: () {},
                            ),
                            UIHelper.verticalSpace(24.h),
                            ProfileWidgets(
                              icon: SvgPicture.asset(AppIcons.notificationIcon),
                              title: 'Notifications',
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
                              onTap: () {},
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
                          onTap: _handleLogout,
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
                  color: Colors.black.withOpacity(0.3),
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
