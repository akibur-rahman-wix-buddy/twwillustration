// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/common_widgets/custom_appbar.dart';
// import 'package:twwillustration/common_widgets/custom_textfeild.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';

// class AddInspireBookScreen extends StatefulWidget {
//   const AddInspireBookScreen({super.key});

//   @override
//   State<AddInspireBookScreen> createState() => _AddInspireBookScreenState();
// }

// class _AddInspireBookScreenState extends State<AddInspireBookScreen> {
//   int counter = 0;
//   String selected = 'Public';
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       appBar: CustomAppbar(
//         title: 'Inspire Book',
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(
//               20,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColor.cFFFFFF,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           AppIcons.cameraOrange,
//                         ),
//                         UIHelper.verticalSpace(10.h),
//                         Text(
//                           'Upload Photo or Take Picture',
//                           style:
//                               TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                             color: AppColor.c000000,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         UIHelper.verticalSpace(5.h),
//                         Text(
//                           '(Al will auto-remove background)',
//                           style:
//                               TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                             color: AppColor.c000000,
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(20.h),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Outfit Details',
//                     style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                       color: AppColor.c000000,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColor.cFFFFFF,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Outfit Name',
//                             style: TextFontStyle.textStyle12w400NunitoSans
//                                 .copyWith(
//                               color: AppColor.c000000,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         UIHelper.verticalSpace(10.h),
//                         CustomTextField(
//                           hintText: 'Enter outfit name',
//                           height: 40.h,
//                         ),
//                         UIHelper.verticalSpace(10.h),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Tag',
//                             style: TextFontStyle.textStyle12w400NunitoSans
//                                 .copyWith(
//                               color: AppColor.c000000,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         UIHelper.verticalSpace(10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColor.cFFFFFF,
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 border: Border.all(
//                                   color: AppColor.c0D1E40,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Pants',
//                                   style: TextFontStyle.textStyle12w400NunitoSans
//                                       .copyWith(
//                                     color: AppColor.c000000,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColor.cFFFFFF,
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 border: Border.all(
//                                   color: AppColor.c0D1E40,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Pants',
//                                   style: TextFontStyle.textStyle12w400NunitoSans
//                                       .copyWith(
//                                     color: AppColor.c000000,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColor.cFFFFFF,
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 border: Border.all(
//                                   color: AppColor.c0D1E40,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Pants',
//                                   style: TextFontStyle.textStyle12w400NunitoSans
//                                       .copyWith(
//                                     color: AppColor.c000000,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColor.cFFFFFF,
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 border: Border.all(
//                                   color: AppColor.c0D1E40,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Add',
//                                   style: TextFontStyle.textStyle12w400NunitoSans
//                                       .copyWith(
//                                     color: AppColor.c000000,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         UIHelper.verticalSpaceMedium,
//                         Row(
//                           children: [
//                             Checkbox(value: false, onChanged: (value) {}),
//                             Text(
//                               'Mark as Favourite',
//                               style: TextFontStyle.textStyle12w400NunitoSans
//                                   .copyWith(
//                                 color: AppColor.c000000,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                         UIHelper.verticalSpace(5.h),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Time worn',
//                             style: TextFontStyle.textStyle12w400NunitoSans
//                                 .copyWith(
//                               color: AppColor.c000000,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         UIHelper.verticalSpace(10.h),
//                         Row(
//                           children: [
//                             // Minus Button
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (counter > 0) counter--;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColor.cFFFFFF,
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   border: Border.all(color: AppColor.c0D1E40),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 10.w, vertical: 10.h),
//                                   child: SvgPicture.asset(AppIcons.minusIcon),
//                                 ),
//                               ),
//                             ),

//                             UIHelper.horizontalSpace(10.w),

//                             // Counter Text
//                             Text(
//                               '$counter',
//                               style: TextFontStyle.textStyle12w400NunitoSans
//                                   .copyWith(
//                                 color: AppColor.c000000,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),

//                             UIHelper.horizontalSpace(10.w),

//                             // Add Button
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   counter++;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColor.cFFFFFF,
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   border: Border.all(color: AppColor.c0D1E40),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 10.w, vertical: 10.h),
//                                   child:
//                                       SvgPicture.asset(AppIcons.additionIcon),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class AddInspireBookScreen extends StatefulWidget {
  const AddInspireBookScreen({super.key});

  @override
  State<AddInspireBookScreen> createState() => _AddInspireBookScreenState();
}

class _AddInspireBookScreenState extends State<AddInspireBookScreen> {

  final _outFitController = TextEditingController();
  final _noteController = TextEditingController();

  int counter = 0;
  String selected = 'Public';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppbar(
        title: 'Inspire Book',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // ---------------- Upload Photo Section ----------------
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.cameraOrange),
                        UIHelper.verticalSpace(10.h),
                        Text(
                          'Upload Photo or Take Picture',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        UIHelper.verticalSpace(5.h),
                        Text(
                          '(AI will auto-remove background)',
                          style:
                              TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ---------------- Outfit Details ----------------
                UIHelper.verticalSpace(20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Outfit Details',
                    style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
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
                        // ---------------- Outfit Name ----------------
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Outfit Name',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              color: AppColor.c000000,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        CustomTextField(
                          controller: _outFitController,
                          hintText: 'Enter outfit name',
                        ),

                        // ---------------- Tag Section ----------------
                        UIHelper.verticalSpace(10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tag',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              color: AppColor.c000000,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            tagBox('Pants'),
                            tagBox('Shirt'),
                            tagBox('Shoes'),
                            tagBox('Add'),
                          ],
                        ),

                        // ---------------- Favourite Checkbox ----------------
                        UIHelper.verticalSpaceMedium,
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Mark as Favourite',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        // ---------------- Time Worn ----------------
                        UIHelper.verticalSpace(5.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Time worn',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              color: AppColor.c000000,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Row(
                          children: [
                            // Minus Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (counter > 0) counter--;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cFFFFFF,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColor.c0D1E40),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: SvgPicture.asset(AppIcons.minusIcon),
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            Text(
                              '$counter',
                              style: TextFontStyle.textStyle12w400NunitoSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  counter++;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cFFFFFF,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColor.c0D1E40),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child:
                                      SvgPicture.asset(AppIcons.additionIcon),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // ---------------- Visibility Section ----------------
                        UIHelper.verticalSpace(20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Visibility',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              color: AppColor.c000000,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'Public';
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 26.w,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: selected == 'Public'
                                          ? AppColor.c0D1E40
                                          : AppColor.cE5E5E5,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: selected == 'Public'
                                          ? Colors.white
                                          : Colors.transparent,
                                      size: 16.sp,
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  Text(
                                    'Public',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.horizontalSpace(30.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'Private';
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 26.w,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: selected == 'Private'
                                          ? AppColor.c0D1E40
                                          : AppColor.cE5E5E5,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: selected == 'Private'
                                          ? Colors.white
                                          : Colors.transparent,
                                      size: 16.sp,
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  Text(
                                    'Private',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Note',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              color: AppColor.c000000,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(10.h),
                        CustomTextField(
                          controller: _noteController,
                          hintText: 'Add a note',
                          maxline: 4,
                        ),
                        UIHelper.verticalSpace(10.h),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(30.h),
                CustomButton(
                    name: 'Save',
                    textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    onCallBack: () {},
                    context: context,
                    color: AppColor.primaryColors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Reusable Tag Widget ----------------
  Widget tagBox(String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.c0D1E40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
            color: AppColor.c000000,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
