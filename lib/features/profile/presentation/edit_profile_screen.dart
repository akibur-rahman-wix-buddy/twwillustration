import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_snakbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/profile/model/edit_profile_model.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/edit_profile_screen_shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GetProfileDataModel? profileData;
  late TextEditingController _bioController;
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _lastNameController;
  late TextEditingController _locationController;

  File? _profileImage;

  bool isLoading = false;
  bool isUpdating = false;

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Take a Photo',
                    style: TextFontStyle.textStyle16w600cFFFFFF,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _profileImage = File(image.path);
                      });
                    }
                  },
                ),
                UIHelper.verticalSpaceSmall,
                ListTile(
                  leading: Icon(
                    Icons.file_copy,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Choose from your file',
                    style: TextFontStyle.textStyle16w600cFFFFFF,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _profileImage = File(image.path);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> fetchProfile() async {
    if(!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      bool sucess = await getProfileRxObj.getProfileRx();
      print('Sucess >>>>>>>>>>>>>>>>>>>>>>> $sucess');

      if (sucess) {
        if(!mounted) return;
        final profile = await getProfileRxObj.getProfileData.first;
        setState(() {
          profileData = profile;
          _bioController.text = profileData?.data?.bio ?? '';
          _firstNameController.text = profileData?.data?.firstName ?? '';
          _lastNameController.text = profileData?.data?.lastName ?? '';
          _emailController.text = profileData?.data?.email ?? '';
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
      if(mounted) {
        setState(() {
        isLoading = false;
      });
      }
      
    }
  }

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _locationController = TextEditingController();
    _emailController = TextEditingController();
    fetchProfile();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    super.dispose();
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
            child: isLoading || isUpdating
                ? ShimmerEditProfileScreen()
                : Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                NavigationService.goBack;
                              },
                              child: SvgPicture.asset(AppIcons.backIcon)),
                          UIHelper.horizontalSpace(80.w),
                          Text(
                            'Edit Profile',
                            style: TextFontStyle.textStyle12w400NunitoSans
                                .copyWith(
                              fontSize: 20.sp,
                              color: AppColor.c000000,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(24.h),

                      // * Profile Picture
                      SizedBox(
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
                              child: (_profileImage != null)
                                  ? Container(
                                      height: 70.h,
                                      width: 70.w,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          _profileImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ShimmerClipOvalWidget(
                                      height: 70.h,
                                      weight: 70.h,
                                      networkImageLink:
                                          profileData?.data?.avatar ?? '',
                                    ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: GestureDetector(
                                onTap: pickProfileImage,
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

                      // * Input Field All
                      UIHelper.verticalSpace(16.h),

                      // TextFiled for Bio >>>>>>>>>>
                      CustomTextField(
                        controller: _bioController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        title: 'Bio',
                        hintText: 'Enter your bio (max 100 characters)',
                        maxline: 3,
                        
                      ),
                      UIHelper.verticalSpace(16.h),

                      // TextFiled for First Name >>>>>>>>>>
                      CustomTextField(
                        controller: _firstNameController,
                        title: 'First Name',
                        hintText: 'Enter your First Name',
                      ),
                      UIHelper.verticalSpace(16.h),

                      // TextFiled for Last Name >>>>>>>>>>
                      CustomTextField(
                        controller: _lastNameController,
                        title: 'Last Name',
                        hintText: 'Enter your Last Name',
                      ),
                      UIHelper.verticalSpace(16.h),

                      // TextFiled for Email >>>>>>>>>>
                      CustomTextField(
                        title: 'Email',
                        controller: _emailController,
                        hintTextSyle: TextFontStyle
                            .textStyle14w500SecondaryColorJosefinSans
                            .copyWith(color: Color(0xFF000000)),
                        readOnly: true,
                        onTap: () =>
                            showSnackBarMessage('You can only see your email'),
                      ),
                      UIHelper.verticalSpace(16.h),

                      // TextFiled for Location >>>>>>>>>>
                      CustomTextField(
                        controller: _locationController,
                        title: 'Location',
                        hintText: 'Enter your Location',
                      ),

                      UIHelper.verticalSpaceMedium,
                      CustomButton(
                        name: 'Changes',
                        onCallBack: () async {
                          setState(() {
                            isUpdating = true;
                          });
                          final firstName = _firstNameController.text.trim();
                          final lastName = _lastNameController.text.trim();
                          final bio = _bioController.text.trim();
                          final email = profileData?.data?.email ?? '';
                          final profileImage = _profileImage;
                          final locaion = _locationController.text.trim();
                          print(
                              '$firstName>>>$lastName>>>$bio>>>>>>>>$email>>>$profileImage>>>>>>$locaion');

                          try {
                            bool success = await postEditProfileRxObj
                                .postEditProfileRx(EditProfileModel(
                                    bio: bio,
                                    firstName: firstName,
                                    lastName: lastName,
                                    profileImage: profileImage,
                                    email: email,
                                    location: locaion));

                            print('Success >>>>>>>>>>>>>>>>>> $success');

                            if (success) {
                       await getProfileRxObj.getProfileRx();
                              ToastUtil.showShortToast(
                                  'Profile update sucessfully');
                              if(mounted){
                                setState(() {
                                  
                                });
                              }
                            } else {
                              throw Exception();
                            }
                          } catch (e) {
                            print(e);
                          } finally {
                            setState(() {
                              isUpdating = false;
                            });
                          }
                        },
                        context: context,
                        color: AppColor.cD5E7B0,
                        borderRadius: 46.r,
                        borderColor: AppColor.cD5E7B0,
                        textStyle:
                            TextFontStyle.textStyle12w400NunitoSans.copyWith(
                          fontSize: 14.sp,
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
