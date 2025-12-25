import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class FollowingScreen extends StatefulWidget {
  final int userId;
  const FollowingScreen({super.key, required this.userId});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  bool isLoading = false;

  List<Map<String, dynamic>> followings = [];
  Future<void> fetchFollowing() async {
    try {
      setState(() {
        isLoading = true;
      });
      int userId = widget.userId;

      bool sucess = await postFollowingRxObj.postFollowingRx(userId);

      if (sucess) {
        postFollowingRxObj.getFollowingData.listen((result) {
          if (!mounted) return;
          setState(() {
            followings =
                List<Map<String, dynamic>>.from(result['data'] as List);
          });
        });
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    20,
                  ),
                  child: Column(
                    children: [
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
                            'Following',
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
                      (followings.isEmpty)
                          ? Center(
                              child: Text(
                                'You haven\'t followed anyone.',
                                style: TextFontStyle
                                    .textStyle20w600c000A15ColorJosefinSans,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: followings.length,
                              itemBuilder: (context, index) {
                                final following = followings[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          ShimmerClipOvalWidget(
                                            height: 48.h,
                                            weight: 48.h,
                                            networkImageLink:
                                                following['avatar'],
                                          ),
                                          UIHelper.horizontalSpace(25),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${following['first_name']} ${following['last_name']}',
                                                style: TextFontStyle
                                                    .textStyle12w400NunitoSans
                                                    .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w900,
                                                  color: AppColor.blackColor,
                                                ),
                                              ),
                                              Text(
                                                '@${following['first_name']} ${following['last_name']}',
                                                style: TextFontStyle
                                                    .textStyle12w400NunitoSans
                                                    .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w900,
                                                  color: AppColor.blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                               CustomButton(
                                                  name:
                                                      following['is_following']
                                                          ? 'Unfollow'
                                                          : 'Follow',
                                                  onCallBack: () async {
                                                    final wasFollowing =
                                                        following[
                                                            'is_following'];
                                                    setState(() {
                                                      following[
                                                              'is_following'] =
                                                          !wasFollowing;
                                                    });
                                                    bool success =
                                                        await toggleFollowUnfollowRxObj
                                                            .toggleFollowUnfollowRx(
                                                                following[
                                                                    'id']);
                                                    await getProfileRxObj.getProfileRx();
                                                    if (!success) {
                                                      setState(() {
                                                        following[
                                                                'is_following'] =
                                                            wasFollowing;
                                                      });
                                                    }
                                                  },
                                                  context: context,
                                                  minWidth: 130.w,
                                                  height: 40.h,
                                                  color: AppColor.cD5E7B0,
                                                  borderColor: AppColor.cD5E7B0,
                                                  textStyle: TextFontStyle
                                                      .textStyle12w400NunitoSans
                                                      .copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w900,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
