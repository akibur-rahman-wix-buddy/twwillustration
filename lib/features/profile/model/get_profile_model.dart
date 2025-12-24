class GetProfileDataModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetProfileDataModel({this.status, this.message, this.code, this.data});

  GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  String? role;
  String? bio;

  Data(
      {this.id,
      this.uuid,
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      this.role,
      this.bio});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    avatar = json['avatar'];
    role = json['role'];
    bio = json['bio'];
  }
}
