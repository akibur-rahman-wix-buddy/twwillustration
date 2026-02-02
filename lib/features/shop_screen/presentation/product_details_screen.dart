import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/constants/app_constants.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_details_model.dart';
import 'package:twwillustration/features/shop_screen/model/get_qa_data_model.dart';
import 'package:twwillustration/features/shop_screen/widget/product_card.dart';
import 'package:twwillustration/features/shop_screen/widget/product_details_shimmer.dart';
import 'package:twwillustration/features/shop_screen/widget/product_slider_card.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/di.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isLoading = true;
  bool postingQuestion = false;
  bool seeAllQuestion = false;
  bool isReplay = false;
  int questionId = 0;

  final _questionController = TextEditingController();

  List<GetMarketplaceProductDetailsModel> _productDetails = [];
  List<GetQADataModel>? _qaList;

  final placeholderImage = [
    const AssetImage(AppImages.placeholderImage),
  ];

  Future<void> fetchMatketplaceProductDetails(int productId) async {
    setState(() => isLoading = true);
    try {
      bool success = await getMarketplaceProductDetailsRxObj.getMarketplaceProductDetailsRx(productId);

      if (success) {
        getMarketplaceProductDetailsRxObj.getMarketplaceProductDetailsData.listen((product) {
          setState(() {
            _productDetails = [product];
            isLoading = false;
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('>>>>error during : $error<<<<<<<');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchQaData(int productId) async {
    try {
      bool success = await getQaDataRxObj.getQaDataRx(productId);
      if (success) {
        getQaDataRxObj.getGetQaData.listen((qa) {
          setState(() {
            _qaList = [qa];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('>>>>>error during get QA : $error <<<<<<<<<<<<');
    }
  }

  Future<void> postAskQuestion(int productId, String question) async {
    setState(() => postingQuestion = true);
    try {
      bool success = await postAskQuestionRxObj.postAskQuestionRx(productId, question);

      if (success) {
        await fetchQaData(productId);
        setState(() {
          _questionController.clear();
          postingQuestion = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('>>>>>error during ask question : $error <<<<<<<<<<<<<<<');
    } finally {
      setState(() => postingQuestion = false);
    }
  }

  Future<void> postAskQuestionReplay(int questionId, String answer) async {
    setState(() => postingQuestion = true);
    try {
      bool success = await postAskQuestionReplayRxObj.postAskQuestionReplayRx(questionId, answer);
      if (success) {
        await fetchQaData(widget.productId);
        setState(() {
          _questionController.clear();
          isReplay = false;
          postingQuestion = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('>>>>>error during ask question replay : $error <<<<<<<<<<<<<<<');
    } finally {
      setState(() => postingQuestion = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMatketplaceProductDetails(widget.productId);
    fetchQaData(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cF3F5F7,
      appBar: CustomAppbar(
        title: 'Product Details',
        backgroundColor: AppColor.cF3F5F7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: isLoading || _productDetails.isEmpty
              ? ProductDetailsShimmer()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductSliderCard(
                      width: double.infinity,
                      height: 300,
                      images: _productDetails.first.data?.product?.images ?? placeholderImage,
                      isFavorite: _productDetails.first.data?.product?.isFav ?? false,
                      onTap: () async {
                        final wasFollowing = _productDetails.first.data?.product?.isFav ?? false;
                        setState(() {
                          _productDetails.first.data?.product?.isFav = !wasFollowing;
                        });
                        bool success = await toggleFavoriteUnfovariteRxObj
                            .toggleFavoriteUnfovariteRx(_productDetails.first.data?.product?.id ?? 0);
                        if (!success) {
                          setState(() {
                            _productDetails.first.data?.product?.isFav = wasFollowing;
                          });
                          await getMarketplaceProductRxObj.getMarketplaceProductRx('', '');
                        }
                      },
                    ),
                    UIHelper.verticalSpace(20.h),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _productDetails.first.data?.product?.title ?? '',
                                    style: TextFontStyle.inter10W800.copyWith(
                                      fontSize: 20.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(8.h),
                                  Text(
                                    '\$${_productDetails.first.data?.product?.price}',
                                    style: TextFontStyle.inter10W800.copyWith(
                                      fontSize: 20.sp,
                                      color: AppColor.c000000,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cF3F5F7,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                  child: Text(
                                    _productDetails.first.data?.product?.condition ?? '',
                                    style: TextFontStyle.inter10W400.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.c757575,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(12.h),
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping_outlined,
                                color: AppColor.c757575,
                                size: 20.sp,
                              ),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                _productDetails.first.data?.product?.shippingOption ?? '',
                                style: TextFontStyle.inter10W400.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.c757575,
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Text(
                            'Descriptions',
                            style: TextFontStyle.inter10W600.copyWith(
                              fontSize: 18.sp,
                              color: AppColor.c000000,
                            ),
                          ),
                          UIHelper.verticalSpace(8.h),
                          ReadMoreText(
                            _productDetails.first.data?.product?.description ?? '',
                            trimLines: 2,
                            colorClickableText: const Color.fromARGB(255, 126, 188, 0),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '  Read More',
                            trimExpandedText: '   Show Less',
                            style: TextFontStyle.inter10W400.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.c757575,
                            ),
                          ),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            'Sizes',
                            style: TextFontStyle.inter10W600.copyWith(
                              fontSize: 18.sp,
                              color: AppColor.c000000,
                            ),
                          ),
                          UIHelper.verticalSpace(8.h),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColors,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              child: Text(
                                _productDetails.first.data?.product?.size ?? '',
                                style: TextFontStyle.inter10W600.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF182245),
                                ),
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                name: 'Chat',
                                onCallBack: () {
                                  NavigationService.navigateTo(Routes.chatScreen);
                                },
                                context: context,
                                minWidth: 150.w,
                                color: AppColor.cFFFFFF,
                                borderColor: AppColor.primaryColors,
                                borderRadius: 80,
                                textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.c000000,
                                ),
                              ),
                              CustomButton(
                                name: 'Buy Now',
                                onCallBack: () {},
                                context: context,
                                minWidth: 150.w,
                                color: AppColor.primaryColors,
                                borderColor: AppColor.primaryColors,
                                borderRadius: 80,
                                textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.c000000,
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(20.h),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(20.h),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.cFFFFFF,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Q&A about this item',
                              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.c000000,
                              ),
                            ),
                            UIHelper.verticalSpace(17.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _questionController,
                                    height: 48.h,
                                    hintText: 'Have a question? Ask here',
                                  ),
                                ),
                                UIHelper.horizontalSpace(12.w),
                                CustomButton(
                                  name: postingQuestion
                                      ? 'Posting..'
                                      : isReplay
                                          ? 'Replay'
                                          : 'Ask',
                                  onCallBack: () async {
                                    if (_questionController.text.trim().isNotEmpty) {
                                      isReplay
                                          ? await postAskQuestionReplay(questionId, _questionController.text.trim())
                                          : await postAskQuestion(widget.productId, _questionController.text.trim());
                                    }
                                  },
                                  context: context,
                                  minWidth: 73.w,
                                  height: 48.h,
                                  color: AppColor.primaryColors,
                                  borderRadius: 80,
                                  textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.c000000,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(17.h),
                            ListView.builder(
                              itemCount: seeAllQuestion
                                  ? _qaList?.first.data?.length
                                  : ((_qaList?.first.data?.length ?? 0) > 2)
                                      ? 2
                                      : _qaList?.first.data?.length,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final qusetsion = _qaList?.first.data?[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColors,
                                              borderRadius: BorderRadius.circular(80.r),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Q',
                                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.c000000,
                                                ),
                                              ),
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(8.w),
                                          Text(
                                            qusetsion?.question ?? '',
                                            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.c000000,
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(8.h),
                                      (qusetsion?.answer?.isEmpty ?? true)
                                          ? _productDetails.first.data?.product?.userId == appData.read(kKeyUserID)
                                              ? Align(
                                                  alignment: Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isReplay = qusetsion?.id == questionId ? !isReplay : true;
                                                        questionId = isReplay ? qusetsion?.id ?? 0 : 0;
                                                      });
                                                    },
                                                    child: Text(
                                                      questionId == qusetsion?.id ? 'Cancel' : 'Replay',
                                                      style:
                                                          TextFontStyle.inter10W600.copyWith(color: Colors.blueAccent),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox.shrink()
                                          : Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColor.primaryColors,
                                                    borderRadius: BorderRadius.circular(80.r),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(
                                                      'A',
                                                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColor.c000000,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                UIHelper.horizontalSpace(8.w),
                                                Text(
                                                  qusetsion?.answer ?? '',
                                                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.c757575,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Divider(
                                        color: AppColor.c637381,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            UIHelper.verticalSpace(10.h),
                            GestureDetector(
                              onTap: () => setState(() {
                                seeAllQuestion = !seeAllQuestion;
                              }),
                              child: Text(
                                seeAllQuestion ? 'View less' : 'View more questions',
                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 118, 176, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Similar items may you like!',
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'View all',
                          style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(20.h),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: _productDetails.first.data?.relatedProducts?.length,
                      itemBuilder: (context, index) {
                        final product = _productDetails.first.data?.relatedProducts?[index];
                        return ProductCard(
                            imageUrl: product?.image ?? '',
                            name: product?.title ?? '',
                            condition: product?.condition ?? '',
                            price: product?.price ?? '',
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                  Routes.productDetailsScreen, {'productId': product?.id ?? 0});
                            },
                            toggleFavorite: () async {
                              final wasFollowing = product?.isFav ?? false;
                              setState(() {
                                product?.isFav = !wasFollowing;
                              });
                              bool success =
                                  await toggleFavoriteUnfovariteRxObj.toggleFavoriteUnfovariteRx(product?.id ?? 0);
                              if (!success) {
                                setState(() {
                                  product?.isFav = wasFollowing;
                                });
                                await getMarketplaceProductRxObj.getMarketplaceProductRx('', '');
                              }
                            },
                            favoriteIcon: (product?.isFav ?? false) ? Icons.favorite : Icons.favorite_border);
                      },
                    ),
                    UIHelper.verticalSpaceMediumLarge
                  ],
                ),
        ),
      ),
    );
  }
}
