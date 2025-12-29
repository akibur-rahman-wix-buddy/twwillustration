class GetBlockUserDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetBlockUserDataModel({this.status, this.message, this.code, this.data});

  GetBlockUserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? createdAt;
  bool? blocked;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.avatar,
      this.createdAt,
      this.blocked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    blocked = json['blocked'];
  }
}
