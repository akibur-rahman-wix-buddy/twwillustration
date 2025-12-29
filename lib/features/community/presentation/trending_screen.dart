// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/widget/post_card.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/post_card_shimmer.dart';

/// demo content pages (replace with your real widgets)
class TrendingTabScreen extends StatefulWidget {
  // final String title;
  const TrendingTabScreen({
    super.key,
  });

  @override
  State<TrendingTabScreen> createState() => _TrendingTabScreenState();
}

class _TrendingTabScreenState extends State<TrendingTabScreen> {
  bool isLoading = false;

  List<GetListOfPostDataModel> _listOfPost = [];

  Future<void> featchListOfPost(String? search, String? filter) async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await getListOfPostRxObj.getListOfPostRx(search, filter);

      if (success) {
        getListOfPostRxObj.getListOfPostData.listen((posts) {
          setState(() {
            _listOfPost = [posts];
          });
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> toggleLikeUnlike(int postId) async{
    try{
      bool success = await toggleLikeUnlikeRxObj.toggleLikeUnlikeRx(postId);
    } catch(error){
      print(error);
    }
  }


  @override
  void initState() {
    super.initState();
    featchListOfPost(null, 'trending');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            UIHelper.verticalSpace(10.h),
            isLoading
                ? PostCardShimmer()
                : _listOfPost.isEmpty ||
                        _listOfPost.first.data == null ||
                        _listOfPost.first.data!.isEmpty
                    ? SizedBox(
                        height: 400.h,
                        width: double.infinity,
                        child: Lottie.asset(AppLotties.noPostFound,
                            fit: BoxFit.contain))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _listOfPost.first.data?.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final post = _listOfPost.first.data?[index];
                          return PostCard(
                            name:
                                '${post?.user?.firstName ?? ''} ${post?.user?.lastName ?? ''}',
                            time: post?.publishedAt ?? '',
                            toggleFollow: () {},
                            title: post?.caption ?? '',
                            descreption: post?.caption ?? '',
                            isFollow: post?.isFollowed ?? '',
                            tag: post?.tags?.map((t) => t.tag ?? "").toList(),
                            onLove: () async{
                              setState(() {
                                if (post?.isLiked == true) {
                                  post?.isLiked = false;
                                  post?.likesCount = (post.likesCount ?? 1) - 1;
                                } else {
                                  post?.isLiked = true;
                                  post?.likesCount = (post.likesCount ?? 0) + 1;
                                }
                              });
                              await toggleLikeUnlike(post?.id ?? 0);
                            },
                            onComment: () {},
                            onShare: () {},
                            likeCount: post?.likesCount ?? 0,
                            commentCount: post?.commentsCount ?? 0,
                            imagePath: post?.medias?.first.path ?? '',
                            isLike: post?.isLiked ?? false,
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
