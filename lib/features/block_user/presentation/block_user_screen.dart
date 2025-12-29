import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/block_user/model/get_block_user_data_model.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/block_user_shimmer.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {

  final _searchController = TextEditingController();
  bool isLoading = false;
  List<GetBlockUserDataModel> _bloclUsers = [];

  Future<void> fetchBlockUser(String? search) async{
    setState(() {
      isLoading = true;
    });
    try{
      bool success = await getBlockUserRxObj.getBlockUserRx(search);

      if(success){
        getBlockUserRxObj.getBlockUserData.listen((blockUsers){
          setState(() {
            _bloclUsers = [blockUsers];
          });
        });
      } else{
        throw Exception();
      }
    } catch(error){
      print(error);
    } finally{
      if(mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBlockUser(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppbar(title: 'Block Users'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                CustomTextField(
                  controller: _searchController,
                  hintText: 'Search blocked users',
                  onChanged: (value) {
                    fetchBlockUser(value);
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Blocked Users (${_bloclUsers.isNotEmpty ? _bloclUsers.first.data?.length : 0})',
                    style: TextFontStyle.Inter10W600.copyWith(
                      fontSize: 12.h,
                      color: AppColor.c000000.withValues(alpha: .4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                isLoading ? BlockUserShimmer() :
                _bloclUsers.isEmpty || _bloclUsers.first.data == null || _bloclUsers.first.data!.isEmpty ?
                Lottie.asset(AppLotties.noBlockUser) :
                ListView.builder(
                  shrinkWrap: true, 
                  physics:
                      const NeverScrollableScrollPhysics(), 
                  itemCount: _bloclUsers.first.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final blockUser = _bloclUsers.first.data?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              ShimmerClipOvalWidget(
                                height: 40,
                                weight: 40,
                                networkImageLink: blockUser?.avatar ?? '',
                              ),
                              UIHelper.horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${blockUser?.firstName ?? ''} ${blockUser?.lastName ?? ''}',
                                    style: TextFontStyle.inter10W400.copyWith(
                                      fontSize: 14.h,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  Text(
                                    'Blocked on ${DateFormat("MMM dd, yyyy").format(DateTime.parse(blockUser?.createdAt ?? ''))}',
                                    style: TextFontStyle.inter10W400.copyWith(
                                      fontSize: 10.h,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.c000000.withValues(alpha: .4),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async{
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try{
                                    bool success = await toggleBlockUnblockRxObj.toggleBlockUnblockRx(blockUser!.id ?? 0);
                                    if(success) await fetchBlockUser(null);
                                  } catch(error){
                                    print(error);
                                  } finally{
                                    setState(() {
                                      isLoading = false;
                                    _searchController.clear();
                                    });
                                  }
                                },
                                child: Text(
                                  'Unblock',
                                  style: TextFontStyle.inter10W400.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFF3B30)
                                  ),
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
