// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/common_widgets/custom_appbar.dart';
// import 'package:twwillustration/helpers/all_routes.dart';
// import 'package:twwillustration/helpers/navigation_service.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';
// import '../assets_helper/app_fonts.dart';
// import '../assets_helper/app_image.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   // All questions (each list = one page)
//   final List<List<String>> allQuestions = [
//     ["Female", "Male", "Non-binary", "Prefer not to say"],
//     ["Under 18", "18-24", "25-34", "35-44", "45-54", "Over 55"],
//     [
//       "Minimalist / Classic",
//       "Casual / Streetwear",
//       "Bold / Statement",
//       "Bohemian / Relaxed",
//       "Business Smart",
//       "Trendy / Edgy"
//     ],
//     [
//       "Neutrals (black, white, beige)",
//       "Earth tones (brown, green, rust)",
//       "Pastels (lavender, mint, blush)",
//       "Brights (red, yellow, blue)",
//       "Dark tones (navy, charcoal, burgundy)"
//     ],
//     [
//       "Office / Study",
//       "Outdoors / Active",
//       "Social Events",
//       "Home / Remote Work"
//     ],
//     [
//       "Comfort",
//       "Style / Aesthetic",
//       "Versatility",
//       "Sustainability / Impact",
//       "Price / Value"
//     ],
//   ];

//   // Titles for each page
//   final List<String> titles = [
//     "What do you identify as?",
//     "What’s your age group?",
//     "Which style speaks most to you?",
//     "Which colors do you gravitate toward?",
//     "Where do you spend most of your week?",
//     "What do you care most about in clothing?",
//   ];

//   final List<String> subTitles = [
//     "Select one answer",
//     "Select one answer",
//     "Select one answer",
//     "Select one answer",
//     "Select one answer",
//     "Select one answer",
//   ];

//   // Page controller
//   final PageController _pageController = PageController();

//   // State variables
//   int _currentIndex = 0;
//   final Map<int, String?> selectedAnswers =
//       {}; // stores selected answer for each question

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.cD5E7B0,
//       body: Stack(
//         children: [
//           // ---------------- Main Container ----------------
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             bottom: 92.h,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColor.cFFFFFF,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40.r),
//                   bottomRight: Radius.circular(40.r),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w),
//                 child: Column(
//                   children: [
//                     UIHelper.verticalSpace(60.h),

//                     // ---------------- Page Indicators ----------------
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(AppIcons.backIcon, height: 32.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(allQuestions.length, (index) {
//                             return Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 4.w),
//                               child: Image.asset(
//                                 _currentIndex == index
//                                     ? AppImages.pgIndicatorFill
//                                     : AppImages.pgIndicator,
//                                 height: 10.h,
//                                 width: 10.w,
//                               ),
//                             );
//                           }),
//                         ),
//                         Text(
//                           'Skip',
//                           style: TextFontStyle.inter10W600.copyWith(
//                             fontSize: 16.sp,
//                             color: AppColor.c000000,
//                           ),
//                         ),
//                       ],
//                     ),

//                     UIHelper.verticalSpace(29.h),

//                     // ---------------- PageView ----------------
//                     Expanded(
//                       child: PageView.builder(
//                         controller: _pageController,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: allQuestions.length,
//                         onPageChanged: (index) {
//                           setState(() => _currentIndex = index);
//                         },
//                         itemBuilder: (context, index) {
//                           final questionList = allQuestions[index];
//                           final selected = selectedAnswers[index];

//                           return SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   titles[index],
//                                   textAlign: TextAlign.center,
//                                   style: TextFontStyle.inter10W600.copyWith(
//                                     fontSize: 18.sp,
//                                     color: AppColor.c000000,
//                                   ),
//                                 ),
//                                 Text(
//                                   subTitles[index],
//                                   textAlign: TextAlign.center,
//                                   style: TextFontStyle.inter10W600.copyWith(
//                                     fontSize: 18.sp,
//                                     color: AppColor.c000000,
//                                   ),
//                                 ),
//                                 UIHelper.verticalSpace(20.h),
//                                 Column(
//                                   children:
//                                       List.generate(questionList.length, (q) {
//                                     final question = questionList[q];
//                                     final isSelected = selected == question;
//                                     return GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedAnswers[index] = question;
//                                         });
//                                       },
//                                       child: Container(
//                                         width: double.infinity,
//                                         margin: EdgeInsets.only(bottom: 12.h),
//                                         decoration: BoxDecoration(
//                                           color: isSelected
//                                               ? AppColor.cD5E7B0
//                                               : AppColor.cFFFFFF,
//                                           border: Border.all(
//                                             color: isSelected
//                                                 ? AppColor.c0D1E40
//                                                 : AppColor.c000000,
//                                             width: 1,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(16.r),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: 12.h,
//                                           horizontal: 16.w,
//                                         ),
//                                         child: Text(
//                                           question,
//                                           textAlign: TextAlign.center,
//                                           style: TextFontStyle.Inter10W400
//                                               .copyWith(
//                                             fontSize: 16.sp,
//                                             color: isSelected
//                                                 ? AppColor.c0D1E40
//                                                 : AppColor.c000000,
//                                             fontWeight: isSelected
//                                                 ? FontWeight.w600
//                                                 : FontWeight.w400,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // ---------------- Bottom Circular Button ----------------
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 45.h,
//             child: Center(
//               child: ClipOval(
//                 child: Container(
//                   height: 91.h,
//                   width: 91.w,
//                   color: AppColor.cD5E7B0,
//                   child: Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         final selected = selectedAnswers[_currentIndex];

//                         // Must select before going next
//                         if (selected == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Please select an option to continue",
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               backgroundColor: Colors.black87,
//                               behavior: SnackBarBehavior.floating,
//                             ),
//                           );
//                           return;
//                         }

//                         // Move next or finish
//                         if (_currentIndex < allQuestions.length - 1) {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         } else {
//                           // ✅ All done → navigate to login
//                           NavigationService.navigateTo(Routes.loginScreen);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: const CircleBorder(),
//                         padding: EdgeInsets.zero,
//                         backgroundColor: Colors.transparent,
//                         elevation: 0,
//                       ),
//                       child: ClipOval(
//                         child: SizedBox(
//                           width: 75.w,
//                           height: 75.h,
//                           child: Image.asset(
//                             AppImages.onbButton,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/constants/app_constants.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/di.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import '../assets_helper/app_fonts.dart';
import '../assets_helper/app_image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with WidgetsBindingObserver {
  // All questions (each list = one page)
  final List<List<String>> allQuestions = [
    ["Female", "Male", "Non-binary", "Prefer not to say"],
    ["Under 18", "18-24", "25-34", "35-44", "45-54", "Over 55"],
    [
      "Minimalist / Classic",
      "Casual / Streetwear",
      "Bold / Statement",
      "Bohemian / Relaxed",
      "Business Smart",
      "Trendy / Edgy"
    ],
    [
      "Neutrals (black, white, beige)",
      "Earth tones (brown, green, rust)",
      "Pastels (lavender, mint, blush)",
      "Brights (red, yellow, blue)",
      "Dark tones (navy, charcoal, burgundy)"
    ],
    [
      "Office / Study",
      "Outdoors / Active",
      "Social Events",
      "Home / Remote Work"
    ],
    [
      "Comfort",
      "Style / Aesthetic",
      "Versatility",
      "Sustainability / Impact",
      "Price / Value"
    ],
  ];

  // Titles for each page
  final List<String> titles = [
    "What do you identify as?",
    "What’s your age group?",
    "Which style speaks most to you?",
    "Which colors do you gravitate toward?",
    "Where do you spend most of your week?",
    "What do you care most about in clothing?",
  ];

  final List<String> subTitles = [
    "Select one answer",
    "Select one answer",
    "Select one answer",
    "Select one answer",
    "Select one answer",
    "Select one answer",
  ];

  // Page controller
  final PageController _pageController = PageController();

  // State variables
  int _currentIndex = 0;
  final Map<int, String?> selectedAnswers = {};


  Future<Position> userLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location Service is Disabled - Please enable it');
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location Permission Denied');
      } else if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions permanently denied');
      }
    } else if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> placeFromLocation(double lat, double long) async {
    try {
      final place = await placemarkFromCoordinates(lat, long);
      String city = place.first.locality ?? 'Unknown Location';
      return city;
    } catch (error) {
      debugPrint('>>error location : $error <<<');
      return 'Unknown Location';
    }
  }

  Future<void> getUserLocation() async {
    print(">>>>>>>>>>call location permission <<<<<<<<<<<<<<<<<<");
    try {
      await Future.delayed(Duration(seconds: 3));
      Position position = await userLocation();
      double lat = position.latitude;
      double long = position.longitude;

      String address = await placeFromLocation(
        lat,
        long,
      );

      print('>>>>>>>>>>>>>>>location = $address <<<<<<<<<<????');

      if (mounted) {
        setState(() {
          appData.write(kKeyUserLocation, address);
        });
      }
    } catch (error) {
      debugPrint('Error getting location: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserLocation(); 
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getUserLocation();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cD5E7B0,
      body: Stack(
        children: [
          // ---------------- Main Container ----------------
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 92.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.cFFFFFF,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    UIHelper.verticalSpace(60.h),

                    // ---------------- Page Indicators & Back Button ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ✅ Back Button
                        GestureDetector(
                          onTap: () {
                            if (_currentIndex > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.pop(context); // exit if on first page
                            }
                          },
                          child: SvgPicture.asset(
                            AppIcons.backIcon,
                            height: 32.h,
                          ),
                        ),

                        // ✅ Page Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(allQuestions.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Image.asset(
                                _currentIndex == index
                                    ? AppImages.pgIndicatorFill
                                    : AppImages.pgIndicator,
                                height: 10.h,
                                width: 10.w,
                              ),
                            );
                          }),
                        ),

                        // ✅ Skip Button
                        GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(Routes.loginScreen);
                          },
                          child: Text(
                            'Skip',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColor.c000000,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    UIHelper.verticalSpace(29.h),

                    // ---------------- PageView ----------------
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allQuestions.length,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemBuilder: (context, index) {
                          final questionList = allQuestions[index];
                          final selected = selectedAnswers[index];

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    titles[index],
                                    textAlign: TextAlign.start,
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(6.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    subTitles[index],
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(20.h),
                                Column(
                                  children:
                                      List.generate(questionList.length, (q) {
                                    final question = questionList[q];
                                    final isSelected = selected == question;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedAnswers[index] = question;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(bottom: 12.h),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColor.cD5E7B0
                                              : AppColor.cFFFFFF,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColor.primaryColors
                                                : AppColor.cE8E8E8,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                          horizontal: 16.w,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            question,
                                            style: TextFontStyle
                                                .textStyle12w400NunitoSans
                                                .copyWith(
                                              fontSize: 14.sp,
                                              color: isSelected
                                                  ? AppColor.c0D1E40
                                                  : AppColor.c000000,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---------------- Bottom Circular Button ----------------
          Positioned(
            left: 0,
            right: 0,
            bottom: 45.h,
            child: Center(
              child: ClipOval(
                child: Container(
                  height: 91.h,
                  width: 91.w,
                  color: AppColor.cD5E7B0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final selected = selectedAnswers[_currentIndex];

                        // Must select before going next
                        if (selected == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Please select an option to continue",
                              ),
                              backgroundColor: Colors.black87,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }

                        // Move next or finish
                        if (_currentIndex < allQuestions.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // ✅ All done → navigate to login
                          NavigationService.navigateTo(Routes.loginScreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          width: 75.w,
                          height: 75.h,
                          child: Image.asset(
                            AppImages.onbButton,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
