// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

/// demo content pages (replace with your real widgets)
class FollowingTabScreen extends StatefulWidget {

  final int userId;
  // final String title;
  const FollowingTabScreen({
    super.key, required this.userId,
  });

  @override
  State<FollowingTabScreen> createState() => _FollowingTabScreenState();
}

class _FollowingTabScreenState extends State<FollowingTabScreen> {
  
  List<bool> loadingStates = List.generate(10, (index) => false);

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
    return  isLoading
            ? Center(
                child: CircularProgressIndicator(),
              ) :
            (followings.isEmpty)
                          ? Center(
                              child: Text(
                                'You haven\'t followed anyone.',
                                style: TextFontStyle
                                    .textStyle20w600c000A15ColorJosefinSans,
                              ),
                            )
                          : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ListView.builder(
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
                                            // লোডিং অবস্থা অনুযায়ী বাটন অথবা লোডিং দেখানো
                                            loadingStates[index]
                                                ? Container(
                                                    width: 130.w,
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.cD5E7B0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color:
                                                              AppColor.cD5E7B0),
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        width: 20.w,
                                                        height: 20.h,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            AppColor.blackColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : CustomButton(
                                                    name: 'Unfollow',
                                                    onCallBack: () {},
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
                          );
  }
}
