import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';

class ManageOutfitScreen extends StatefulWidget {
  const ManageOutfitScreen({super.key});

  @override
  State<ManageOutfitScreen> createState() => _ManageOutfitScreenState();
}

class _ManageOutfitScreenState extends State<ManageOutfitScreen> {
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.cFFFFFF,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigationService.goBack();
                              },
                              child: SvgPicture.asset(
                                AppIcons.backIcon,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                NavigationService.navigateTo(Routes.outfitPreview);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cD5E7B0,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    10,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Next'),
                                      SvgPicture.asset(AppIcons.nextIcons),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Image.asset(
                          AppImages.shirtBigImage,
                        ),
                        Image.asset(
                          AppImages.pantBigImage,
                        ),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.addCloth,
                          ),
                          UIHelper.verticalSpace(10.h),
                          Text('Add Cloth'),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.addStickers,
                          ),
                          UIHelper.verticalSpace(10.h),
                          Text('Add Cloth'),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.addBackground,
                          ),
                          UIHelper.verticalSpace(10.h),
                          Text('Add Cloth'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
