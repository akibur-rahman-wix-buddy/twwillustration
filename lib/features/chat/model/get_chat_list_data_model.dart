class GetChatListDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetChatListDataModel({this.status, this.message, this.code, this.data});

  GetChatListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? lastMessage;
  String? lastImage;
  String? lastMessageAt;
  int? unreadCount;
  User? user;

  Data(
      {this.id,
      this.lastMessage,
      this.lastImage,
      this.lastMessageAt,
      this.unreadCount,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastMessage = json['last_message'];
    lastImage = json['last_image'];
    lastMessageAt = json['last_message_at'];
    unreadCount = json['unread_count'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  bool? isOnline;

  User({this.id, this.firstName, this.lastName, this.avatar, this.isOnline});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    isOnline = json['is_online'];
  }
}
