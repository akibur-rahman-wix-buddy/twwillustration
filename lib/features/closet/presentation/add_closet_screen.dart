// import 'dart:io';

// import 'package:background_remover/background_remover.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:local_rembg/local_rembg.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/assets_helper/app_image.dart';
// import 'package:twwillustration/common_widgets/custom_button.dart';
// import 'package:twwillustration/helpers/all_routes.dart';
// import 'package:twwillustration/helpers/navigation_service.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';

// class AddClosetScreen extends StatefulWidget {
//   const AddClosetScreen({super.key});

//   @override
//   State<AddClosetScreen> createState() => _AddClosetScreenState();
// }

// class _AddClosetScreenState extends State<AddClosetScreen> {
//   Uint8List? selectedImage;

//   bool isBgRemoved = false;

//   final _picker = ImagePicker();

// pickGelarryImage() async {
//   final image = await _picker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     final Uint8List imageByte = await image.readAsBytes();

//     setState(() {
//       selectedImage = imageByte;   // প্রথমে raw image দেখাও
//       isBgRemoved = false;
//     });

//     print('>>>>>>>>>>>>>>> bg remove running <<<<<<<<<<<<<<<');

//     // local_rembg ব্যবহার করো
//     final LocalRembgResultModel result = await LocalRembg.removeBackground(
//       imageUint8List: imageByte,
//       cropTheImage: true, // চাইলে false দিতে পারো
//     );

//     setState(() {
//       selectedImage = result.imageUint8List; // background remove করা image
//       isBgRemoved = true;
//     });
//   }
// }

// pickCameraImage() async {
//   final image = await _picker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     final Uint8List imageByte = await image.readAsBytes();

//     setState(() {
//       selectedImage = imageByte;
//       isBgRemoved = false;
//     });

//     print('>>>>>>>>>>>>>>> bg remove running <<<<<<<<<<<<<<<');

//     final LocalRembgResultModel result = await LocalRembg.removeBackground(
//       imageUint8List: imageByte,
//       cropTheImage: true,
//     );

//     setState(() {
//       selectedImage = result.imageUint8List;
//       isBgRemoved = true;
//     });
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 UIHelper.verticalSpace(80.h),
//                 const Row(
//                   children: [
//                     Icon(Icons.photo_camera_back_outlined,
//                         color: Colors.black87, size: 22),
//                     SizedBox(width: 8),
//                     Text(
//                       'Upload Photo Item',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 150.w,
//                       margin: const EdgeInsets.symmetric(horizontal: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           pickGelarryImage();
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 24),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 AppIcons.upPhoto,
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Upload Photo',
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 150.w,
//                       margin: const EdgeInsets.symmetric(horizontal: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           pickCameraImage();
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 24),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 AppIcons.takePhoto,
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Take Photo',
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 200,
//                   width: 200,
//                   child: (selectedImage != null) ?
//                   Image.memory(selectedImage!, fit: BoxFit.contain,) : Text('No image found'),
//                 ),
//                 // UIHelper.verticalSpace(380.h),
//                 selectedImage != null
//                     ? isBgRemoved
//                         ? Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color(0xFFE1FBB9),
//                                     Color(0xFFE6F0EA)
//                                   ]),
//                               color: const Color(0xFFDDF8DD),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 10),
//                             child: Row(
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Image.asset(
//                                       AppImages.removeImage,
//                                       height: 58.h.h,
//                                       width: 58.w.w,
//                                     ),
//                                     SvgPicture.asset(AppIcons.checkMark)
//                                   ],
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Expanded(
//                                   child: Text(
//                                     'Clothes Added',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color(0xFFE1FBB9),
//                                     Color(0xFFE6F0EA)
//                                   ]),
//                               color: const Color(0xFFDDF8DD),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 10),
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   AppImages.removeImage,
//                                   height: 58.h,
//                                   width: 58.w,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                     child: RichText(
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                       text: 'Removing Background\n',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                         text: 'Don’t close this app',
//                                         style: TextFontStyle.inter10W400
//                                             .copyWith(
//                                                 color: Color(0xFF757575),
//                                                 fontSize: 14.sp))
//                                   ]),
//                                 )
//                                     // Text(
//                                     //   'Removing Background',
//                                     //   style: TextStyle(
//                                     //     fontSize: 16,
//                                     //     fontWeight: FontWeight.w600,
//                                     //     color: Colors.black87,
//                                     //   ),
//                                     // ),
//                                     ),
//                                 InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         selectedImage = null; isBgRemoved = false;
//                                       });
//                                     },
//                                     child: GestureDetector(
//                                         child:
//                                             SvgPicture.asset(AppIcons.cancel)))
//                               ],
//                             ),
//                           )
//                     : SizedBox.shrink(),
//                 UIHelper.verticalSpaceMedium,
//                 isBgRemoved
//                     ? CustomButton(
//                         name: "Continue",
//                         borderRadius: 100.r,
//                         textStyle: TextFontStyle.inter10W400
//                             .copyWith(color: Colors.black, fontSize: 14.sp),
//                         color: Color(0xFFE1FBB9),
//                         onCallBack: () {},
//                         context: context)
//                     : SizedBox.shrink()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// * ##########################################################################
// * ##########################################################################

// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:local_rembg/local_rembg.dart'; // <-- নতুন প্যাকেজ
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/assets_helper/app_image.dart';
// import 'package:twwillustration/common_widgets/custom_button.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';

// class AddClosetScreen extends StatefulWidget {
//   const AddClosetScreen({super.key});

//   @override
//   State<AddClosetScreen> createState() => _AddClosetScreenState();
// }

// class _AddClosetScreenState extends State<AddClosetScreen> {
//   Uint8List? selectedImage;
//   bool isBgRemoved = false;
//   final _picker = ImagePicker();

// Future<void> pickGelarryImage() async {
//   final image = await _picker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     final Uint8List imageByte = await image.readAsBytes();

//     setState(() {
//       selectedImage = imageByte; // raw image preview
//       isBgRemoved = false;
//     });

//     print('>>>>>>>>>>>>>>> bg remove running <<<<<<<<<<<<<<<');

//     final LocalRembgResultModel result = await LocalRembg.removeBackground(
//       imageUint8List: imageByte,
//       cropTheImage: true,
//     );

//     if (result.status == 1 && result.imageBytes != null) {
//       setState(() {
//         selectedImage = Uint8List.fromList(result.imageBytes!); // <-- এখানে imageBytes ব্যবহার করো
//         isBgRemoved = true;
//       });
//     } else {
//       print("Background remove failed: ${result.errorMessage}");
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 UIHelper.verticalSpace(80.h),
//                 const Row(
//                   children: [
//                     Icon(Icons.photo_camera_back_outlined,
//                         color: Colors.black87, size: 22),
//                     SizedBox(width: 8),
//                     Text(
//                       'Upload Photo Item',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildUploadButton("Upload Photo", AppIcons.upPhoto, pickGelarryImage),
//                     // _buildUploadButton("Take Photo", AppIcons.takePhoto, pickCameraImage),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 200,
//                   width: 200,
//                   child: (selectedImage != null)
//                       ? Image.memory(selectedImage!, fit: BoxFit.contain)
//                       : const Text('No image found'),
//                 ),
//                 const SizedBox(height: 20),
//                 selectedImage != null
//                     ? isBgRemoved
//                         ? _buildStatusContainer("Clothes Added", true)
//                         : _buildStatusContainer("Removing Background\nDon’t close this app", false)
//                     : const SizedBox.shrink(),
//                 UIHelper.verticalSpaceMedium,
//                 isBgRemoved
//                     ? CustomButton(
//                         name: "Continue",
//                         borderRadius: 100.r,
//                         textStyle: TextFontStyle.inter10W400
//                             .copyWith(color: Colors.black, fontSize: 14.sp),
//                         color: const Color(0xFFE1FBB9),
//                         onCallBack: () {},
//                         context: context)
//                     : const SizedBox.shrink()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadButton(String text, String icon, VoidCallback onTap) {
//     return Container(
//       width: 150.w,
//       margin: const EdgeInsets.symmetric(horizontal: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           const BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(icon),
//               const SizedBox(height: 10),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusContainer(String message, bool success) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFE1FBB9), Color(0xFFE6F0EA)]),
//         color: const Color(0xFFDDF8DD),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Row(
//         children: [
//           success
//               ? Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Image.asset(AppImages.removeImage, height: 58.h, width: 58.w),
//                     SvgPicture.asset(AppIcons.checkMark),
//                   ],
//                 )
//               : Image.asset(AppImages.removeImage, height: 58.h, width: 58.w),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               message,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           if (!success)
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedImage = null;
//                   isBgRemoved = false;
//                 });
//               },
//               child: SvgPicture.asset(AppIcons.cancel),
//             )
//         ],
//       ),
//     );
//   }
// }

// * #########################################################################
// * #########################################################################
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_remove_bg/flutter_remove_bg.dart'; // remove.bg প্যাকেজ
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class AddClosetScreen extends StatefulWidget {
  const AddClosetScreen({super.key});

  @override
  State<AddClosetScreen> createState() => _AddClosetScreenState();
}

class _AddClosetScreenState extends State<AddClosetScreen> {
  Uint8List? selectedImage, processedImageBytes;
  bool isBgRemoved = false;
  final _picker = ImagePicker();

  Future<void> pickGelarryImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageByte = await image.readAsBytes();

      setState(() {
        selectedImage = imageByte; 
        isBgRemoved = false;
      });

      print('>>>>>>>>>>>>>>> bg remove running <<<<<<<<<<<<<<<');

      try {
        final removeBg = RemoveBg(apiKey: "qGCr3dxfnhRwRwWAMzrQ3oqz");

        final List<int> processedImageBytes =
            await removeBg.removeBackground(image.path);

        setState(() {
          selectedImage =
              Uint8List.fromList(processedImageBytes);
          isBgRemoved = true;
        });
      } catch (e) {
        print("Background remove failed: $e");
        setState(() {
          selectedImage = imageByte;
          isBgRemoved = false;
        });
      }
    }
  }

  Future<void> pickCameraImage() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final Uint8List imageByte = await image.readAsBytes();

      setState(() {
        selectedImage = imageByte; 
        isBgRemoved = false;
      });

      print('>>>>>>>>>>>>>>> bg remove running <<<<<<<<<<<<<<<');

      try {
        final removeBg = RemoveBg(apiKey: "qGCr3dxfnhRwRwWAMzrQ3oqz");

        final List<int> processedImageBytes =
            await removeBg.removeBackground(image.path);

        setState(() {
          selectedImage =
              Uint8List.fromList(processedImageBytes);
          isBgRemoved = true;
        });
      } catch (e) {
        print("Background remove failed: $e");
        setState(() {
          selectedImage = imageByte;
          isBgRemoved = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(80.h),
                const Row(
                  children: [
                    Icon(Icons.photo_camera_back_outlined,
                        color: Colors.black87, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Upload Photo Item',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUploadButton(
                        "Upload Photo", AppIcons.upPhoto, pickGelarryImage),
                        _buildUploadButton(
                        "Take Photo", AppIcons.takePhoto, pickCameraImage),
                  ],
                ),
                SizedBox(height: 320.h),
                selectedImage != null
                    ? isBgRemoved
                        ? _buildStatusContainer("Clothes Added", true)
                        : _buildStatusContainer(
                            "Removing Background\nDon’t close this app", false)
                    : const SizedBox.shrink(),
                UIHelper.verticalSpaceMedium,
                isBgRemoved
                    ? CustomButton(
                        name: "Continue",
                        borderRadius: 100.r,
                        textStyle: TextFontStyle.inter10W400
                            .copyWith(color: Colors.black, fontSize: 14.sp),
                        color: const Color(0xFFE1FBB9),
                        onCallBack: () {
                          NavigationService.navigateToWithArgs(Routes.closetDetailsAddScreen, {
                            'imageBytes' : selectedImage
                          });
                        },
                        context: context)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton(String text, String icon, VoidCallback onTap) {
    return Container(
      width: 150.w,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusContainer(String message, bool success) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE1FBB9), Color(0xFFE6F0EA)]),
        color: const Color(0xFFDDF8DD),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          success
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppImages.removeImage,
                        height: 58.h, width: 58.w),
                    SvgPicture.asset(AppIcons.checkMark),
                  ],
                )
              : Image.asset(AppImages.removeImage, height: 58.h, width: 58.w),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          if (!success)
            InkWell(
              onTap: () {
                setState(() {
                  selectedImage = null;
                  isBgRemoved = false;
                });
              },
              child: SvgPicture.asset(AppIcons.cancel),
            )
        ],
      ),
    );
  }
}
