import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/features/FAQ/model/get_faq_data_model.dart';
import 'package:twwillustration/features/FAQ/widget/faq_item.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/faq_shimmer.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  bool isLoading = false;
  int selectedIndex = -1;

  List<GetFAQDataModel> _listOfFAQ = [];

  Future<void> fetchFaq() async{
    setState(() {
      isLoading = true;
    });
    try{
      bool success = await getFaqRxObj.getFaqRx();

      if(success){
        getFaqRxObj.getFaqData.listen((data){
          setState(() {
            _listOfFAQ = [data];
          });
        });
      }
    } catch(error){
      print(error);
    } finally{
      if(mounted) setState(()=> isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFaq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService.goBack();
                    },
                    child: SvgPicture.asset(AppIcons.backIcon),
                  ),
                  Text(
                    'FAQ',
                    style: TextFontStyle.Inter10W700.copyWith(
                      fontSize: 20.sp,
                      color: AppColor.c000000,
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              Text(
                'Frequently Asked Questions',
                style: TextFontStyle.Inter10W600.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.c000000,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              isLoading ? FaqShimmer() :
              _listOfFAQ.isEmpty || _listOfFAQ.first.data == null || _listOfFAQ.first.data!.isEmpty ?
              Lottie.asset(AppLotties.noFaqFfound) :
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _listOfFAQ.first.data?.length,
                  itemBuilder: (context, index) {
                    final faq = _listOfFAQ.first.data?[index];
                    return FaqItem(
                      question: faq?.question ?? '',
                      iconButton: IconButton(
                        onPressed: (){
                          setState(() {
                            selectedIndex = index;
                          });
                        }, 
                        icon: selectedIndex == index 
                        ? Icon(Icons.keyboard_arrow_down, size: 15.sp, color: Color(0xFF757575),)
                        : Icon(Icons.arrow_forward_ios, size: 15.sp, color: Color(0xFF757575),)
                        ),
                      answerr: faq?.answer ?? '',
                      ans: selectedIndex == index,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
