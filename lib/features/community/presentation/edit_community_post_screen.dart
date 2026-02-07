import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_image.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_shimmer_image.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart';
import 'package:twwillustration/features/community/widget/edit_community_post_shimmer.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class EditCommunityPostScreen extends StatefulWidget {
  final int postId;

  const EditCommunityPostScreen({super.key, required this.postId});

  @override
  State<EditCommunityPostScreen> createState() => _EditCommunityPostScreenState();
}

class _EditCommunityPostScreenState extends State<EditCommunityPostScreen> {
  bool isLoading = true;

  bool isUpdating = false;

  late TextEditingController _captionController;

  late List<String> _tags;

  GetPostDetailsDataModel? postDetails;

  final List<String> _visibilityOptions = const ['published', 'private'];
  late String _visibility;

  Future<void> fetchPostDetails(int postId) async {
    setState(() => isLoading = true);
    try {
      final success = await getPostDetailsRxObj.getPostDEtailsRx(postId);
      if (success) {
        getPostDetailsRxObj.getPostDetailsData.listen((postDetailsData) {
          if (!mounted) return;
          setState(() {
            postDetails = postDetailsData;
            _captionController.text = postDetails?.data?.caption ?? '';
            _visibility = postDetails?.data?.visibility ?? '';
            _tags.addAll(postDetails?.data?.tags?.map((e) => e.tag ?? '').toList() ?? []);
            isLoading = false;
          });
        });
      } else {
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    _tags = []; 
    fetchPostDetails(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Post',
          style: TextFontStyle.inter10W800.copyWith(color: AppColor.c000000, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? EditCommunityPostShimmer()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // -------- Main media card --------
                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(12.r), dashPattern: [4, 2], strokeWidth: 1, color: Colors.grey),
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.white),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ShimmerImage(
                            imageUrl: postDetails?.data?.media?.path ?? '',
                            placeholder: AppImages.placeholderImage,
                            height: 180.h,
                            width: double.infinity,
                            boxFit: BoxFit.contain,
                          )),
                    ),

                    UIHelper.verticalSpace(24.h),

                    Text(
                      'Caption',
                      style: TextFontStyle.inter10W500.copyWith(fontSize: 16, color: Color(0xFF5E5E5E)),
                    ),

                    UIHelper.verticalSpace(9.h),

                    // -------- Caption --------
                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(12.r), dashPattern: [4, 2], strokeWidth: 1, color: Colors.grey),
                      child: Container(
                        height: 175.h,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
                        child: CustomTextField(
                          controller: _captionController,
                          fieldColor: Colors.transparent,
                          borderColor: Colors.transparent,
                          maxline: 7,
                          height: 172.h,
                          hintText: 'Write a caption...',
                          hintTextSyle: TextFontStyle.inter10W400.copyWith(fontSize: 16.sp, color: Color(0xFF757575)),
                        ),
                      ),
                    ),

                    UIHelper.verticalSpace(20.h),
                    // -------- Tags --------
                    Text(
                      'Tag',
                      style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    UIHelper.verticalSpace(10.h),

                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F7F9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: [
                          for (int i = 0; i < _tags.length; i++) _buildTagChip(_tags[i], i),
                          ActionChip(
                            avatar: const Icon(Icons.add, size: 18),
                            label: Text(
                              'Add tag',
                              style: TextFontStyle.inter10W400.copyWith(fontSize: 16.sp, color: Color(0xFF757575)),
                            ),
                            onPressed: _onAddTagTap,
                            backgroundColor: Colors.white,
                            shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ),

                    UIHelper.verticalSpace(20.h),

                    // -------- Visibility (new) --------
                    _visibilityRow(),

                    UIHelper.verticalSpace(24.h),
                    CustomButton(
                      name: isUpdating ? 'Updating...' : 'Update',
                      borderRadius: 46.r,
                      height: 47.h,
                      onCallBack: () {
                        // if(_captionController.text.isNotEmpty){
                        //   final post = PostAddPostDataModel(
                        //   caption: _captionController.text.trim(),
                        //   image: postDetails?.data?.media?.path ?? '',
                        //   tags: _tags,
                        //   visibility: _visibility
                        //   );

                        //   postAddPost(post);
                        // }
                      },
                      context: context,
                      color: AppColor.cD5E7B0,
                      textStyle: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Chip _buildTagChip(String tag, int index) {
    return Chip(
      label: Text(
        '#$tag',
        style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
          fontSize: 16.sp,
          color: Color(0xFF757575),
          fontWeight: FontWeight.w600,
        ),
      ),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () => setState(() => _tags.removeAt(index)),
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Future<void> _onAddTagTap() async {
    final controller = TextEditingController();
    final newTag = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add tag'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'e.g. EcoStyle', border: OutlineInputBorder()),
          onSubmitted: (_) => Navigator.pop(context, controller.text.trim()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('Add')),
        ],
      ),
    );
    if (newTag == null) return;
    final clean = newTag.replaceAll(RegExp(r'^#'), '').trim();
    if (clean.isEmpty || _tags.contains(clean)) return;
    setState(() => _tags.add(clean));
  }

  Widget _visibilityRow() {
    return InkWell(
      onTap: _showVisibilitySheet,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Text(
              'Visibility',
              style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                fontSize: 14.sp,
                color: AppColor.c000000,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              _visibility,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  void _showVisibilitySheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _visibilityOptions.map((opt) {
            final bool isSelected = opt == _visibility;
            return ListTile(
              leading: Icon(
                opt == 'Public'
                    ? Icons.public
                    : opt == 'Friends'
                        ? Icons.group
                        : Icons.lock,
              ),
              title: Text(opt),
              trailing: isSelected ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _visibility = opt);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
