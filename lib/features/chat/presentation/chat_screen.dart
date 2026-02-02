import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twwillustration/assets_helper/app_colors.dart';
import 'package:twwillustration/assets_helper/app_fonts.dart';
import 'package:twwillustration/assets_helper/app_icons.dart';
import 'package:twwillustration/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:twwillustration/features/chat/model/get_specific_user_chat_data_model.dart';
import 'package:twwillustration/features/chat/widget/chat_image_viewer.dart';
import 'package:twwillustration/features/chat/widget/image_picker_bottom_sheet.dart';
import 'package:twwillustration/features/chat/widget/message_bubbles.dart';
import 'package:twwillustration/helpers/ui_helpers.dart';
import 'package:twwillustration/networks/api_acess.dart';

class ChatScreen extends StatefulWidget {
  final int userId;

  const ChatScreen({super.key, required this.userId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  List<Data> messages = [];
  Sender? _otherUser;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchChatData();
  }

  Future<void> fetchChatData() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool success = await getSpecificUserChatRxObj.getChatListRx(widget.userId);

      if (success) {
        getSpecificUserChatRxObj.getMaterialsData.listen((chat) {
          if (mounted) {
            setState(() {
              messages = chat.data ?? [];
              if (messages.isNotEmpty) {
                final firstMessage = messages.first;
                if (firstMessage.sender?.id == widget.userId) {
                  _otherUser = firstMessage.sender;
                } else if (firstMessage.receiver?.id == widget.userId) {
                  _otherUser = firstMessage.sender;
                } else {
                  _otherUser = firstMessage.sender;
                }
              }

              isLoading = false;
            });
            _scrollToBottom();
          }
        });
      } else {
        throw Exception('Failed to fetch chat data');
      }
    } catch (error) {
      debugPrint('Error during fetch: $error');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool _isCurrentUserSender(Data message) {
    return message.sender?.id != widget.userId;
  }

  String _getOtherUserName() {
    if (_otherUser == null) return 'User';

    String firstName = _otherUser?.firstName ?? '';
    String lastName = _otherUser?.lastName ?? '';

    return '$firstName $lastName'.trim().isEmpty ? 'User' : '$firstName $lastName'.trim();
  }

  String _getOtherUserAvatar() {
    return _otherUser?.avatar ?? '';
  }

  bool _isOtherUserOnline() {
    return _otherUser?.isOnline ?? false;
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    try {
      if (_messageController.text.trim().isEmpty) {
        debugPrint('>>>>>> Message is empty <<<<<<');
        return;
      }

      String messageText = _messageController.text.trim();
      debugPrint('>>>>>> Sending message: $messageText <<<<<<');
      debugPrint('>>>>>> Receiver ID: ${widget.userId} <<<<<<');

      _messageController.clear();

      bool success = await sendMessageRxObj.sendTextMessageRx(
        receiverId: widget.userId,
        message: messageText,
      );

      debugPrint('>>>>>> Send success: $success <<<<<<');

      if (success) {
        debugPrint('>>>>>> Fetching chat data <<<<<<');
        fetchChatData();
      } else {
        debugPrint('>>>>>> Send failed <<<<<<');
        throw Exception('Send message failed');
      }
    } catch (error) {
      debugPrint('>>>>>>>>error during send message : $error <<<<<<<<<<<<<<');
    }
  }

  void _showImagePickerOptions() {
  ImagePickerBottomSheet.show(
    context: context,
    allowMultiple: true,
    onImagesSelected: (List<XFile> pickedFiles) async {
      if (pickedFiles.isNotEmpty) {
        List<String> imagePaths = pickedFiles.map((file) => file.path).toList();

        setState(() {
          isLoading = true;
        });

        bool success = await sendMessageRxObj.sendImagesRx(
          receiverId: widget.userId,
          images: imagePaths,
        );

        if (success) {
          await fetchChatData(); 
        }

        setState(() {
          isLoading = false;
        });
      }
    },
    onImageCaptured: (XFile photo) async {
      setState(() {
        isLoading = true;
      });

      bool success = await sendMessageRxObj.sendImagesRx(
        receiverId: widget.userId,
        images: [photo.path],
      );

      if (success) {
        await fetchChatData();
      }

      setState(() {
        isLoading = false;
      });
    },
  );
}

  void _openImageViewer(List<String> imagePaths, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          imagePaths: imagePaths,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.backIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            ShimmerClipOvalWidget(
              height: 40.w,
              weight: 40.w,
              networkImageLink:
                  _getOtherUserAvatar().isEmpty ? 'https://i.pravatar.cc/150?img=12' : _getOtherUserAvatar(),
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getOtherUserName(),
                  style: TextFontStyle.inter10W600.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.c000000,
                  ),
                ),
                Text(
                  _isOtherUserOnline() ? 'Active Now' : 'Offline',
                  style: TextFontStyle.inter10W400.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.c757575,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? Center(
                          child: Text(
                            'No messages yet',
                            style: TextFontStyle.inter10W400.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.c757575,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: EdgeInsets.all(16.w),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final reversedIndex = messages.length - 1 - index;
                            final message = messages[reversedIndex];
                            final isSent = _isCurrentUserSender(message);

                            return MessageBubble(
                              message: message,
                              isSent: isSent,
                              onImageTap: (imagePaths, initialIndex) {
                                _openImageViewer(imagePaths, initialIndex);
                              },
                            );
                          },
                        ),
                ),
                _buildInputArea(),
              ],
            ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(AppIcons.cameraIcon),
              onPressed: _showImagePickerOptions,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: TextField(
                  controller: _messageController,
                  onSubmitted: (value) => _sendMessage(),
                  style: TextFontStyle.inter10W400.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.c000000,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a Message',
                    hintStyle: TextFontStyle.inter10W400.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              decoration: const BoxDecoration(
                color: AppColor.cD5E7B0,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: SvgPicture.asset(AppIcons.sendsIcon),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
