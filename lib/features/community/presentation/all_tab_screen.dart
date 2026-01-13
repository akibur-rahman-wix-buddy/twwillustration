import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/assets_helper/app_lottie.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart' as postDetails;
import 'package:twwillustration/features/community/widget/post_card.dart';
import 'package:twwillustration/features/community/widget/post_comments_part.dart';
import 'package:twwillustration/networks/api_acess.dart';
import 'package:twwillustration/shimmer_widget/post_card_shimmer.dart';

/// demo content pages (replace with your real widgets)
class AllTabScreen extends StatefulWidget {
  const AllTabScreen({super.key});

  @override
  State<AllTabScreen> createState() => _AllTabScreenState();
}

class _AllTabScreenState extends State<AllTabScreen> {
  bool isLoading = false;
  bool commentLoading = false;

  List<postDetails.Comments> comments = [];

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

  Future<void> fetchPostDetails(int postId) async {
    setState(() {
      commentLoading = true;
    });
    try {
      bool success = await getPostDetailsRxObj.getPostDEtailsRx(postId);
      print('>>>>>>>>>>>>>>> success : $success <<<<<<<<<<<<<<<<<');
      if (success) {
        getPostDetailsRxObj.getPostDetailsData.listen((postDetails) {
          setState(() {
            comments = postDetails.data?.comments ?? [];
            commentLoading = false;
          });
        });
      } else {
        setState(() {
          commentLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        commentLoading = false;
      });
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

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isLoading
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
                            fetchPostDetails(post.id ?? 0);
                            // if (!commentLoading) {
                            //   showModalBottomSheet(
                            //     context: context,
                            //     isScrollControlled: true,
                            //     backgroundColor: Colors.white,
                            //     shape: const RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            //     ),
                            //     builder: (_) => CommentSheet(
                            //       comments: comments,
                            //       onSend: (text) {
                            //         print("New comment added: $text");
                            //       },
                            //     ),
                            //   );
                            // }
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                builder: (_) => CommentSheet(
                                  comments: comments,
                                  onSend: (text) {
                                    print("New comment added: $text");
                                  },
                                ),
                              );
                            // CommentSheet(comments: comments);
                            // final List<postDetails.Comments> commentsData = [
                            //   postDetails.Comments(
                            //     id: 1,
                            //     comment: "This is a top-level comment",
                            //     createdAt: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
                            //     user: postDetails.User(
                            //       firstName: "Sarah",
                            //       lastName: "Johnson",
                            //       avatar: "https://randomuser.me/api/portraits/women/44.jpg",
                            //     ),
                            //     replies: [
                            //       postDetails.Replies(
                            //         id: 101,
                            //         comment: "This is a reply to Sarah",
                            //         createdAt: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
                            //         user: postDetails.User(
                            //           firstName: "John",
                            //           lastName: "Doe",
                            //           avatar: "https://randomuser.me/api/portraits/men/34.jpg",
                            //         ),
                            //         replies: [
                            //           postDetails.Replies(
                            //             id: 101,
                            //             comment: "This is a reply to Sarah",
                            //             createdAt: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
                            //             user: postDetails.User(
                            //               firstName: "Arif",
                            //               lastName: "Doe",
                            //               avatar: "https://randomuser.me/api/portraits/men/34.jpg",
                            //             ),
                            //             replies: [
                            //               postDetails.Replies(
                            //                 id: 101,
                            //                 comment: "This is a reply to Sarah",
                            //                 createdAt:
                            //                     DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
                            //                 user: postDetails.User(
                            //                   firstName: "Rasel",
                            //                   lastName: "Doe",
                            //                   avatar: "https://randomuser.me/api/portraits/men/34.jpg",
                            //                 ),
                            //                 replies: [
                            //                   postDetails.Replies(
                            //                     id: 101,
                            //                     comment: "This is a reply to Sarah",
                            //                     createdAt:
                            //                         DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
                            //                     user: postDetails.User(
                            //                       firstName: "Jobayer",
                            //                       lastName: "Doe",
                            //                       avatar: "https://randomuser.me/api/portraits/men/34.jpg",
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       postDetails.Replies(
                            //         id: 102,
                            //         comment: "Another reply",
                            //         createdAt: DateTime.now().subtract(const Duration(minutes: 50)).toIso8601String(),
                            //         user: postDetails.User(
                            //           firstName: "Jane",
                            //           lastName: "Smith",
                            //           avatar: "https://randomuser.me/api/portraits/women/65.jpg",
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   postDetails.Comments(
                            //     id: 2,
                            //     comment: "Another top-level comment",
                            //     createdAt: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
                            //     user: postDetails.User(
                            //       firstName: "John",
                            //       lastName: "Doe",
                            //       avatar: "https://randomuser.me/api/portraits/men/34.jpg",
                            //     ),
                            //     replies: [], // No replies for this one
                            //   ),
                            // ];

                            // // Show bottom sheet
                            // CommentSheet.show(
                            //   context,
                            //   comments: commentsData,
                            //   onSend: (text) {
                            //     print("New comment added: $text");
                            //     // Call your API or update your state here
                            //   },
                            // );
                          },
                          onShare: () {},
                          likeCount: post.likesCount ?? 0,
                          commentCount: post.commentsCount ?? 0,
                          imagePath: imagePath,
                          isLike: post.isLiked ?? false,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}

// class CommentBottomSheet {
//   static void show(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return const CommentSheetContent();
//       },
//     );
//   }
// }

// class CommentSheetContent extends StatelessWidget {
//   const CommentSheetContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.6,
//       minChildSize: 0.4,
//       maxChildSize: 0.9,
//       builder: (context, scrollController) {
//         return Column(
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Comments (2)",
//                     style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w800,
//                       color: AppColor.blackColor,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   )
//                 ],
//               ),
//             ),
//             const Divider(height: 1),

//             // Comments list
//             Expanded(
//               child: ListView.builder(
//                 controller: scrollController,
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const CircleAvatar(
//                           radius: 18,
//                           backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Sarah Johnson",
//                                 style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13.sp,
//                                   color: AppColor.blackColor,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
//                                 style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                                   fontSize: 12.sp,
//                                   color: AppColor.blackColor,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "2h ago",
//                                     style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                                       fontSize: 12.sp,
//                                       color: AppColor.c000000,
//                                     ),
//                                   ),
//                                   SizedBox(width: 16),
//                                   Text(
//                                     "Like",
//                                     style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                                       fontSize: 12.sp,
//                                       color: AppColor.c000000,
//                                     ),
//                                   ),
//                                   SizedBox(width: 16),
//                                   Text(
//                                     "Reply",
//                                     style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                                       fontSize: 12.sp,
//                                       color: AppColor.c000000,
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Add comment field
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         hintText: "Add a comment...",
//                         controller: TextEditingController(),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColor.cD5E7B0,
//                         borderRadius: BorderRadius.circular(30.r),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: SvgPicture.asset(
//                           AppIcons.sendsIcon,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
