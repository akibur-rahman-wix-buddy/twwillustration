import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/custom_appbar.dart';
import 'package:twwillustration/common_widgets/custom_button.dart';
import 'package:twwillustration/common_widgets/custom_snackbar.dart';
import 'package:twwillustration/common_widgets/custom_textfeild.dart';
import 'package:twwillustration/features/community/model/post_add_post_data_model.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  final _captionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // Main picked image (hero card)
  XFile? _pickedImage;

  // Closet images (array)
  final List<XFile> _closetImages = [];

  // Tags (array)
  final List<String> _tags = <String>[];

  // Visibility
  final List<String> _visibilityOptions = const [
    'published',
    'private'
  ];
  String _visibility = 'published';

  bool isPosting = false;

  Future<void> postAddPost(PostAddPostDataModel post) async{
    setState(() {
      isPosting = true;
    });
    try{
      bool success = await postAddPostRxObj.postAddPostRx(post);
      if(success){
        showSnackBarMessage(context, 'Posted Sucessfully');
        setState(() {
          isPosting = false;
        });
      } else{
        throw Exception();
      }
    } catch(error){
      print(error);
    }
  }

  // ===================== Media Picker (main card) =====================
  void _showSourceSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(
                'Camera',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                final XFile? img =
                    await _picker.pickImage(source: ImageSource.camera);
                if (img != null) setState(() => _pickedImage = img);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                'Gallery',
                style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                final XFile? img =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (img != null) setState(() => _pickedImage = img);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===================== Closet Section =====================
  void _showClosetAddSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Add from Camera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? shot =
                    await _picker.pickImage(source: ImageSource.camera);
                if (shot != null) {
                  setState(() => _closetImages.add(shot));
                  _logClosetArray();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Add from Gallery (multi)'),
              onTap: () async {
                Navigator.pop(context);
                final picks = await _picker.pickMultiImage();
                if (picks.isNotEmpty) {
                  setState(() => _closetImages.addAll(picks));
                  _logClosetArray();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _logClosetArray() {
    final paths = _closetImages.map((e) => e.path).toList();
    // ignore: avoid_print
    print('CLOSET ARRAY: $paths');
  }

  Widget _buildClosetTile(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.file(file, width: 72.w, height: 72.w, fit: BoxFit.cover),
    );
  }

  Widget _buildAddTile() {
    return InkWell(
      onTap: _showClosetAddSheet,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 72.w,
        height: 72.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFDFE2E6), width: 1),
        ),
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }

  // ===================== Tags =====================
  Future<void> _onAddTagTap() async {
    final controller = TextEditingController();
    final newTag = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add tag'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
              hintText: 'e.g. EcoStyle', border: OutlineInputBorder()),
          onSubmitted: (_) => Navigator.pop(context, controller.text.trim()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Add')),
        ],
      ),
    );
    if (newTag == null) return;
    final clean = newTag.replaceAll(RegExp(r'^#'), '').trim();
    if (clean.isEmpty || _tags.contains(clean)) return;
    setState(() => _tags.add(clean));
    // ignore: avoid_print
    print('TAGS ARRAY: $_tags');
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

  // ===================== Visibility =====================
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
            const Icon(Icons.keyboard_arrow_down,
                size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppbar(title: 'Create a Post'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // -------- Main media card --------
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(12.r),
                    dashPattern: [4,2],
                    strokeWidth: 1,
                    color: Colors.grey
                    ),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: _showSourceSheet,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.white),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _pickedImage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.cameraIcon,
                                    height: 40.h, width: 40.w),
                                UIHelper.verticalSpace(10.h),
                                Text(
                                  'Add Photo',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'PNG, JPG (max 10 MB)',
                                  style: TextFontStyle.textStyle12w400NunitoSans
                                      .copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(File(_pickedImage!.path),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity),
                        ),
                  ),
                ),
                ),

                UIHelper.verticalSpace(24.h),

                Text(
                  'Caption',
                  style: TextFontStyle.Inter10W500.copyWith(
                    fontSize: 16,
                    color: Color(0xFF5E5E5E)
                  ),
                ),

                UIHelper.verticalSpace(9.h),

                // -------- Caption --------
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(12.r),
                    dashPattern: [4,2],
                    strokeWidth: 1,
                    color: Colors.grey
                    ),
                  child: Container(
                    height: 175.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white
                    ),
                    child: CustomTextField(
                      controller: _captionController,
                      fieldColor: Colors.transparent,
                      borderColor: Colors.transparent,
                         maxline: 7, 
                         height: 172.h,
                         hintText: 'Write a caption...',
                         hintTextSyle: TextFontStyle.inter10W400.copyWith(
                            fontSize: 16.sp,
                            color: Color(0xFF757575)
                          ),
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
                      for (int i = 0; i < _tags.length; i++)
                        _buildTagChip(_tags[i], i),
                      ActionChip(
                        avatar: const Icon(Icons.add, size: 18),
                        label: Text(
                          'Add tag',
                          style: TextFontStyle.inter10W400.copyWith(
                            fontSize: 16.sp,
                            color: Color(0xFF757575)
                          ),
                        ),
                        onPressed: _onAddTagTap,
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.grey.shade300)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(20.h),

                // -------- Select From Closet --------
                Text(
                  'Select From Closet',
                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7F9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ..._closetImages.map((x) => Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: _buildClosetTile(File(x.path)),
                            )),
                        _buildAddTile(),
                      ],
                    ),
                  ),
                ),

                UIHelper.verticalSpace(20.h),


                // -------- Visibility (new) --------
                _visibilityRow(),

                UIHelper.verticalSpace(24.h),
                CustomButton(
                  name: isPosting ? 'Posting...' : 'Post',
                  borderRadius: 46.r,
                  height: 47.h,
                  onCallBack: () {
                    if(_captionController.text.isNotEmpty && _pickedImage != null ){
                      final post = PostAddPostDataModel(
                      caption: _captionController.text.trim(), 
                      image: _pickedImage!, 
                      tags: _tags, 
                      visibility: _visibility
                      );

                      postAddPost(post);
                    } else if(_pickedImage == null){
                      showSnackBarMessage(context, 'Image is required');
                    } else if(_captionController.text.isEmpty){
                      showSnackBarMessage(context, 'Caption is required');
                    }
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
      ),
    );
  }
}
