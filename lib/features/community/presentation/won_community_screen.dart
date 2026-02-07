import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/common_widgets/custom_snackbar.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/widget/post_card.dart';
import 'package:twwillustration/features/community/widget/post_comments_part.dart';
import 'package:twwillustration/helpers/all_routes.dart';
import 'package:twwillustration/helpers/navigation_service.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/post_card_shimmer.dart';

class WonCommunityScreen extends StatefulWidget {
  const WonCommunityScreen({super.key});

  @override
  State<WonCommunityScreen> createState() => _WonCommunityScreenState();
}

class _WonCommunityScreenState extends State<WonCommunityScreen> {
  bool isLoading = true;

  List<GetListOfPostDataModel> _listOfPost = [];

  Future<void> featchListOfPost(String? search, String? filter) async {
    setState(() => isLoading = true);

    try {
      final success = await getListOfPostRxObj.getListOfPostRx(search, filter);

      if (!success) throw Exception();

      getListOfPostRxObj.getListOfPostData.listen((posts) {
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

  Future<void> deletePost(int postId) async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await deleteCommunityPostRxObj.deleteCommunityPostRx(postId);

      if (success) {
        showSnackBarMessage(context, 'Post Deleted');
        await featchListOfPost(null, 'my');
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (error) {
      debugPrint('$error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    featchListOfPost(null, 'my');
  }

  @override
  Widget build(BuildContext context) {
    final posts = _listOfPost.isNotEmpty ? _listOfPost.first.data : null;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My Community',
          style: TextFontStyle.inter10W800.copyWith(color: AppColor.c000000, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: isLoading
              ? const PostCardShimmer()
              : posts == null || posts.isEmpty
                  ? SizedBox(
                      height: 300.h,
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
                          clickThreeDot: () {
                            final screenHeight = MediaQuery.of(context).size.height;
                            final screenWidth = MediaQuery.of(context).size.width;

                            final postTopPosition = index * 500.0;
                            final isNearBottom = postTopPosition > screenHeight * 0.6;

                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                screenWidth - 150,
                                isNearBottom ? postTopPosition - 100 : postTopPosition + 100,
                                0,
                                0,
                              ),
                              items: [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit Post'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ).then((value) {
                              if (value == 'edit') {
                                NavigationService.navigateToWithArgs(Routes.editCommunityPsotScreen, {'postId' : post.id});
                              } else if (value == 'delete') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirmation"),
                                      content: Text("Are you sure you want to delete this post?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            deletePost(post.id ?? 0);
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          },
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
                          isLike: post.isLiked ?? false,
                          userId: 1,
                          wonProfile: true,
                        );
                      },
                    )),
    );
  }
}
