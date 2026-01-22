import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart' as postDetails;
import 'package:twwillustration/networks/api_acess.dart';

class CommentSheet extends StatefulWidget {
  final int postId;

  const CommentSheet({
    super.key,
    required this.postId,
  });

  static void show(
    BuildContext context, {
    required int postId,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CommentSheet(postId: postId),
    );
  }

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final TextEditingController _controller = TextEditingController();
  bool commentLoading = false;
  List<postDetails.Comments> comments = [];
  int? parentId;

  @override
  void initState() {
    super.initState();
    fetchPostDetails(widget.postId);
  }

  Future<void> fetchPostDetails(int postId) async {
    setState(() => commentLoading = true);
    try {
      final success = await getPostDetailsRxObj.getPostDEtailsRx(postId);
      if (success) {
        getPostDetailsRxObj.getPostDetailsData.listen((postDetailsData) {
          if (!mounted) return;
          setState(() {
            comments = postDetailsData.data?.comments ?? [];
            commentLoading = false;
          });
        });
      } else {
        if (mounted) setState(() => commentLoading = false);
      }
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) setState(() => commentLoading = false);
    }
  }

  Future<void> postComment(int postId, int? parentId, String comment) async {
    try {
      final success = await postCommentRxObj.postCommentRx(postId, parentId, comment);
      if (success) {
        if (mounted) {
          setState(() {
            _controller.clear();
          });
        }
        await fetchPostDetails(postId);
        await getListOfPostRxObj.getListOfPostRx(null, null);
      } else {
        throw Exception("Comment failed");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String formatTimeAgo(String? dateTimeString) {
    if (dateTimeString == null) return "";
    final dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime == null) return "";
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  // ✅ Reply renderer
  Widget buildReplyItem(postDetails.Replies reply, String parentUserName, {bool isNested = false}) {
    final replyUser = "${reply.user?.firstName ?? ''} ${reply.user?.lastName ?? ''}".trim();
    final replyAvatar = reply.user?.avatar ?? "https://via.placeholder.com/150";

    return Padding(
      padding: EdgeInsets.only(left: isNested ? 0 : 40, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 14, backgroundImage: NetworkImage(replyAvatar)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(replyUser.isNotEmpty ? replyUser : "Unknown",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "@$parentUserName ",
                            style: TextStyle(color: Colors.blue, fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: reply.comment ?? "",
                            style: TextStyle(color: Colors.black, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(formatTimeAgo(reply.createdAt), style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () async {
                            final wasLike = reply.isLiked;
                            setState(() {
                              reply.isLiked = !wasLike!;
                            });
                            bool success = await postCommentLikeRxObj.postCommentLikeRx(reply.id ?? 0);
                            await getProfileRxObj.getProfileRx();
                            if (!success) {
                              setState(() {
                                reply.isLiked = wasLike;
                              });
                            }
                          },
                          child: Text(
                            reply.isLiked ?? false ? "Liked" : "Like",
                            style: TextStyle(
                              color: reply.isLiked == true ? Colors.blue : Colors.black,
                              fontWeight: reply.isLiked == true ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              parentId = reply.id;
                              String firstName = (reply.user?.firstName ?? '').split(" ").first;
                              _controller.text = "@$firstName ";
                              _controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length),
                              );
                            });
                          },
                          child: const Text("Reply"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (reply.replies?.isNotEmpty == true)
            Column(
              children: reply.replies!.map((nested) => buildReplyItem(nested, replyUser, isNested: true)).toList(),
            ),
        ],
      ),
    );
  }

  Widget buildSkeleton() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14, width: 100, color: Colors.grey.shade300),
                    const SizedBox(height: 8),
                    Container(height: 12, width: double.infinity, color: Colors.grey.shade300),
                    const SizedBox(height: 6),
                    Container(height: 12, width: 60, color: Colors.grey.shade300),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Comments (${comments.length})",
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.blackColor,
                      )),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: commentLoading
                  ? buildSkeleton()
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final userName = "${comment.user?.firstName ?? ''} ${comment.user?.lastName ?? ''}".trim();
                        final avatarUrl = comment.user?.avatar ?? "https://via.placeholder.com/150";

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(radius: 18, backgroundImage: NetworkImage(avatarUrl)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(userName.isNotEmpty ? userName : "Unknown",
                                            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                              color: AppColor.blackColor,
                                            )),
                                        const SizedBox(height: 4),
                                        Text(comment.comment ?? "",
                                            style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColor,
                                            )),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(formatTimeAgo(comment.createdAt),
                                                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                                                  fontSize: 12.sp,
                                                  color: AppColor.c000000,
                                                )),
                                            const SizedBox(width: 16),
                                            GestureDetector(
                                                onTap: () async {
                                                  final wasLike = comment.isLiked;
                                                  setState(() {
                                                    comment.isLiked = !wasLike!;
                                                  });
                                                  bool success =
                                                      await postCommentLikeRxObj.postCommentLikeRx(comment.id ?? 0);
                                                  await getProfileRxObj.getProfileRx();
                                                  if (!success) {
                                                    setState(() {
                                                      comment.isLiked = wasLike;
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  comment.isLiked ?? false ? "Liked" : "Like",
                                                  style: TextStyle(
                                                    color: comment.isLiked == true ? Colors.blue : Colors.black,
                                                    fontWeight:
                                                        comment.isLiked == true ? FontWeight.bold : FontWeight.normal,
                                                  ),
                                                )),
                                            const SizedBox(width: 16),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  parentId = comment.id;
                                                  String mentionName = (comment.user?.firstName ?? '').split(" ").first;
                                                  _controller.text = "@$mentionName ";
                                                  _controller.selection = TextSelection.fromPosition(
                                                    TextPosition(offset: _controller.text.length),
                                                  );
                                                });
                                              },
                                              child: const Text("Reply"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (comment.replies?.isNotEmpty == true)
                                Column(
                                  children: comment.replies!.map((reply) => buildReplyItem(reply, userName)).toList(),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            // SafeArea(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: CustomTextField(
            //             hintText: "Add a comment...",
            //             controller: _controller,
            //           ),
            //         ),
            //         const SizedBox(width: 8),
            //         InkWell(
            //           onTap: () async {
            //             if (_controller.text.trim().isNotEmpty) {
            //               String rawText = _controller.text.trim();
            //               String commentText = rawText;
            //               if (rawText.startsWith("@")) {
            //                 int firstSpace = rawText.indexOf(" ");
            //                 if (firstSpace != -1) {
            //                   commentText = rawText.substring(firstSpace + 1).trim();
            //                 } else {
            //                   commentText = "";
            //                 }
            //               }
            //               if (commentText.isNotEmpty) {
            //                 await postComment(widget.postId, parentId, commentText);
            //                 setState(() {
            //                   parentId = null;
            //                 });
            //                 _controller.clear();
            //               }
            //             }
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: AppColor.cD5E7B0,
            //               borderRadius: BorderRadius.circular(30.r),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.all(16.0),
            //               child: SvgPicture.asset(AppIcons.sendsIcon),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Add a comment...",
                          controller: _controller,
                          maxline: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () async {
                          if (_controller.text.trim().isNotEmpty) {
                            String rawText = _controller.text.trim();
                            String commentText = rawText;

                            if (rawText.startsWith("@")) {
                              int firstSpace = rawText.indexOf(" ");
                              if (firstSpace != -1) {
                                commentText = rawText.substring(firstSpace + 1).trim();
                              } else {
                                commentText = "";
                              }
                            }

                            if (commentText.isNotEmpty) {
                              await postComment(widget.postId, parentId, commentText);
                              setState(() {
                                parentId = null;
                              });
                              _controller.clear();
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.cD5E7B0,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SvgPicture.asset(AppIcons.sendsIcon),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
