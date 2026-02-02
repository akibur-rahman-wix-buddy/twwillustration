// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:twwillustration/assets_helper/app_colors.dart';
// import 'package:twwillustration/assets_helper/app_fonts.dart';
// import 'package:twwillustration/assets_helper/app_icons.dart';
// import 'package:twwillustration/common_widgets/custom_textfeild.dart';
// import 'package:twwillustration/features/chat/model/get_chat_list_data_model.dart';
// import 'package:twwillustration/features/chat/widget/chat_list_screen_shimmer.dart';
// import 'package:twwillustration/features/chat/widget/chat_list_widget.dart';
// import 'package:twwillustration/helpers/all_routes.dart';
// import 'package:twwillustration/helpers/navigation_service.dart';
// import 'package:twwillustration/helpers/ui_helpers.dart';
// import 'package:twwillustration/networks/api_acess.dart';

// class ChatListScreen extends StatefulWidget {
//   const ChatListScreen({super.key});

//   @override
//   State<ChatListScreen> createState() => _ChatListScreenState();
// }

// class _ChatListScreenState extends State<ChatListScreen> {

//   final _searchController = TextEditingController();

//   GetChatListDataModel? _chatList;

//   bool isLoading = true;

//   Future<void> fetchChatList(String? search) async{
//     setState(() => isLoading = true,);
//     try{
//       bool success = await getChatListRxObj.getChatListRx(search);

//       if(success){
//         getChatListRxObj.getMaterialsData.listen((chats){
//           setState(() {
//             _chatList = chats;
//             isLoading = false;
//           });
//         });
//       } else{
//         throw Exception();
//       }
//     } catch(error){
//       debugPrint('>>> error during : $error <<<<<<');
//     } finally{
//       setState(() => isLoading = false,);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchChatList('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.cFFFFFF,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 UIHelper.verticalSpace(10.h),
//                 GestureDetector(onTap: () => NavigationService.goBack, child: SvgPicture.asset(AppIcons.backIcon)),
//                Text(
//                   'Messages',
//                   style: TextFontStyle.inter10W800.copyWith(fontSize: 24.sp, color: AppColor.c000000),
//                 ),
//                 UIHelper.verticalSpace(10.h),
//               CustomTextField(
//                 controller: _searchController,
//                 leftIcon: AppIcons.searchIcon,
//                 height: 56.h,
//                 hintText: "Search....",
//                 onChanged: (value) {

//                 },
//               ),
//               UIHelper.verticalSpace(16.h),
//               Expanded(
//                 child:
//                 isLoading ? ChatListShimmer() :
//                 _chatList == null || _chatList!.data!.isEmpty ? Text('No data') :
//                  ListView.builder(
//                   itemCount: _chatList?.data?.length,
//                   itemBuilder: (context, index){
//                     final chat = _chatList?.data?[index];
//                     return ChatListWidget(
//                       onTap: (){NavigationService.navigateToWithArgs(Routes.chatScreen, {'userId' : chat?.user?.id ?? 0});}, avatar: 'https://images.pexels.com/photos/35842222/pexels-photo-35842222.jpeg',
//                       name: '${chat?.user?.firstName} ${chat?.user?.lastName}',
//                       messege: chat?.lastMessage ?? '',
//                       unReadMessage: chat?.unreadCount ?? 0, time: chat?.lastMessageAt ?? ''
//                     );
//                   }
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twwillustration/features/chat/model/get_chat_list_data_model.dart';
import 'package:twwillustration/features/chat/presentation/chat_screen.dart';
import 'package:twwillustration/features/chat/widget/chat_list_widget.dart';
import 'package:twwillustration/networks/api_acess.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool isLoading = false;
  List<Data> chatList = [];
  String currentSearchQuery = ''; // Track current search

  @override
  void initState() {
    super.initState();
    fetchChatList('');
  }

  Future<void> fetchChatList(String? search) async {
    setState(() {
      isLoading = true;
      currentSearchQuery = search ?? ''; // Save current search
    });

    try {
      bool success = await getChatListRxObj.getChatListRx(search);

      if (success) {
        getChatListRxObj.getMaterialsData.listen((chatData) {
          if (mounted) {
            setState(() {
              chatList = chatData.data ?? [];
              isLoading = false;
            });
          }
        });
      } else {
        throw Exception('Failed to fetch chat list');
      }
    } catch (error) {
      debugPrint('Error fetching chat list: $error');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshChatList() async {
    await fetchChatList(currentSearchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              onChanged: (value) {
                fetchChatList(value);
              },
              decoration: InputDecoration(
                hintText: 'Search chats...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : chatList.isEmpty
                    ? const Center(child: Text('No chats available'))
                    : RefreshIndicator(
                        onRefresh: _refreshChatList,
                        child: ListView.builder(
                          padding: EdgeInsets.all(16.w),
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            final chat = chatList[index];
                            return _buildChatListItem(chat);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem(Data chat) {
    final user = chat.user;
    final userName = '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
    final userAvatar = user?.avatar ?? '';

    String displayMessage = '';
    bool hasImage = false;

    if (chat.lastImage != null && chat.lastImage!.isNotEmpty) {
      hasImage = true;
      if (chat.lastMessage == null || chat.lastMessage!.isEmpty) {
        displayMessage = '';
      } else {
        displayMessage = chat.lastMessage!;
      }
    } else {
      displayMessage = chat.lastMessage ?? 'No messages yet';
    }

    return ChatListWidget(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userId: user?.id ?? 0,
            ),
          ),
        ).then((_) {
          fetchChatList('');
        });
      },
      avatar: userAvatar,
      name: userName.isEmpty ? 'Unknown User' : userName,
      messege: displayMessage,
      unReadMessage: chat.unreadCount ?? 0,
      time: chat.lastMessageAt ?? '',
      hasImage: hasImage,
    );
  }
}
