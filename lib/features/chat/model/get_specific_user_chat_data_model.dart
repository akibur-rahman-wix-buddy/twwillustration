class GetSpecificUserChatDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetSpecificUserChatDataModel(
      {this.status, this.message, this.code, this.data});

  GetSpecificUserChatDataModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  dynamic image;
  String? messageAt;
  bool? isSeen;
  Sender? sender;
  Receiver? receiver;
  dynamic product;

  Data(
      {this.id,
      this.message,
      this.image,
      this.messageAt,
      this.isSeen,
      this.sender,
      this.receiver,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    image = json['image'];
    messageAt = json['message_at'];
    isSeen = json['is_seen'];
    sender =
        json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? Receiver.fromJson(json['receiver'])
        : null;
    product = json['product'];
  }
}

class Sender {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  bool? isOnline;

  Sender({this.id, this.firstName, this.lastName, this.avatar, this.isOnline});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    isOnline = json['is_online'];
  }
}

class Receiver {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  bool? isOnline;

  Receiver(
      {this.id, this.firstName, this.lastName, this.avatar, this.isOnline});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    isOnline = json['is_online'];
  }
}
