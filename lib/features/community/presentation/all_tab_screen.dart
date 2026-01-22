import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/widget/post_card.dart';
import 'package:twwillustration/features/community/widget/post_comments_part.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/post_card_shimmer.dart';

class AllTabScreen extends StatefulWidget {
  const AllTabScreen({super.key});

  @override
  State<AllTabScreen> createState() => _AllTabScreenState();
}

class _AllTabScreenState extends State<AllTabScreen> {
  bool isLoading = false;

  List<GetListOfPostDataModel> _listOfPost = [];
  StreamSubscription? _postSub;

  Future<void> featchListOfPost(String? search, String? filter) async {
    setState(() => isLoading = true);

    try {
      bool success = await getListOfPostRxObj.getListOfPostRx(search, filter);

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
    featchListOfPost(null, 'all');
  }

  @override
  void dispose() {
    _postSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = _listOfPost.isNotEmpty ? _listOfPost.first.data : null;

    return isLoading
        ? const PostCardShimmer()
        : posts == null || posts.isEmpty
            ? SizedBox(
                height: 400.h,
                width: double.infinity,
                child: Lottie.asset(
                  AppLotties.noPostFound,
                  fit: BoxFit.contain,
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  final imagePath = post.medias?.isNotEmpty == true ? post.medias!.first.path ?? '' : '';

                  return PostCard(
                    name: '${post.user?.firstName ?? ''} ${post.user?.lastName ?? ''}',
                    time: post.publishedAt ?? '',
                    toggleFollow: () {},
                    descreption: post.caption ?? '',
                    tag: post.tags?.map((t) => t.tag ?? '').toList(),
                    isFollow: post.isFollowed ?? '',
                    onLove: () async {
                      setState(() {
                        if (post.isLiked == true) {
                          post.isLiked = false;
                          post.likesCount = (post.likesCount ?? 1) - 1;
                        } else {
                          post.isLiked = true;
                          post.likesCount = (post.likesCount ?? 0) + 1;
                        }
                      });
                      await toggleLikeUnlike(post.id ?? 0);
                    },
                    onComment: () {
                      CommentSheet.show(context, postId: post.id ?? 0);
                    },
                    onShare: () {},
                    likeCount: post.likesCount ?? 0,
                    commentCount: post.commentsCount ?? 0,
                    imagePath: imagePath,
                    isLike: post.isLiked ?? false, userId: 1,
                  );
                },
              );
  }
}
