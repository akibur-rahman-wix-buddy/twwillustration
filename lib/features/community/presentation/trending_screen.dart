// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/widget/post_card.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/post_card_shimmer.dart';

class TrendingTabScreen extends StatefulWidget {
  const TrendingTabScreen({super.key});

  @override
  State<TrendingTabScreen> createState() => _TrendingTabScreenState();
}

class _TrendingTabScreenState extends State<TrendingTabScreen> {
  bool isLoading = false;

  List<GetListOfPostDataModel> _listOfPost = [];
  StreamSubscription? _postSub;

  Future<void> featchListOfPost(String? search, String? filter) async {
    setState(() => isLoading = true);

    try {
      final success =
          await getListOfPostRxObj.getListOfPostRx(search, filter);

      if (!success) throw Exception();

      _postSub?.cancel();
      _postSub = getListOfPostRxObj.getListOfPostData.listen((posts) {
        if (!mounted) return;
        setState(() {
          _listOfPost = [posts];
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> toggleLikeUnlike(int postId) async {
    try {
      await toggleLikeUnlikeRxObj.toggleLikeUnlikeRx(postId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    featchListOfPost(null, 'trending');
  }

  @override
  void dispose() {
    _postSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts =
        _listOfPost.isNotEmpty ? _listOfPost.first.data : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            UIHelper.verticalSpace(10.h),

            if (isLoading)
              const PostCardShimmer()
            else if (posts == null || posts.isEmpty)
              SizedBox(
                height: 400.h,
                width: double.infinity,
                child: Lottie.asset(
                  AppLotties.noPostFound,
                  fit: BoxFit.contain,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  final imagePath =
                      post.medias?.isNotEmpty == true
                          ? post.medias!.first.path ?? ''
                          : '';

                  return PostCard(
                    name:
                        '${post.user?.firstName ?? ''} ${post.user?.lastName ?? ''}',
                    time: post.publishedAt ?? '',
                    toggleFollow: () {},
                    descreption: post.caption ?? '',
                    isFollow: post.isFollowed ?? '',
                    tag: post.tags?.map((e) => e.tag ?? '').toList(),
                    onLove: () async {
                      setState(() {
                        if (post.isLiked == true) {
                          post.isLiked = false;
                          post.likesCount =
                              (post.likesCount ?? 1) - 1;
                        } else {
                          post.isLiked = true;
                          post.likesCount =
                              (post.likesCount ?? 0) + 1;
                        }
                      });
                      await toggleLikeUnlike(post.id ?? 0);
                    },
                    onComment: () {},
                    onShare: () {},
                    likeCount: post.likesCount ?? 0,
                    commentCount: post.commentsCount ?? 0,
                    imagePath: imagePath,
                    isLike: post.isLiked ?? false,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
