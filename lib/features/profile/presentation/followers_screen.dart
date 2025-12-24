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

class FollowersScreen extends StatefulWidget {
  final int userId;
  const FollowersScreen({super.key, required this.userId});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<bool> loadingStates = List.generate(10, (index) => false);

  bool isLoading = false;

  List<Map<String, dynamic>> followers = [];
  Map<String, dynamic> followingList = {};

  Future<void> fetchFollower() async {
    try {
      setState(() {
        isLoading = true;
      });
      int userId = widget.userId;

      bool sucess = await postFollowerRxObj.postFollowerRx(userId);

      if (sucess) {
        postFollowerRxObj.getFollowerData.listen((result) {
          if(!mounted) return;
          setState(() {
            followers = List<Map<String, dynamic>>.from(result['data'] as List);
          });
        });
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print(error);
    } finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toggleFollowUnfollow(int id) async{
    try{
      bool success = await toggleFollowUnfollowRxObj.toggleFollowUnfollowRx(id);

      if(success){
        toggleFollowUnfollowRxObj.getFollowUnfollowData.listen((data){
          if(!mounted) return;
          setState(() {
            followingList = data['data'];
          });
        });
      }
    }catch(error){
      print(error);
    }
  }

  void _handleFollowBack(int index) async {
    setState(() {
      loadingStates[index] = true;
    });
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      loadingStates[index] = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFollower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator(),) :
            SingleChildScrollView(
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
                      'Followers',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                followers.isEmpty ? Center(child: Text(
                  'No one has followed you.',
                  style: TextFontStyle.textStyle20w600primaryColor2JosefinSans,
                ),) :
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    final follower = followers[index];
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
                                networkImageLink: follower['avatar'],
                              ),
                              UIHelper.horizontalSpace(25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${follower['first_name']} ${follower['last_name']}',
                                    style: TextFontStyle
                                        .textStyle12w400NunitoSans
                                        .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '@${follower['first_name']} ${follower['last_name']}',
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
                              // লোডিং অবস্থা অনুযায়ী বাটন অথবা লোডিং দেখানো
                              loadingStates[index]
                                  ? Container(
                                      width: 130.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.cD5E7B0,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: AppColor.cD5E7B0),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              AppColor.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CustomButton(
                                      name: follower['is_following'] ? 'Unfollow' : 'Follow Back',
                                      onCallBack: () {
                                        toggleFollowUnfollow(follower['id']);
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
