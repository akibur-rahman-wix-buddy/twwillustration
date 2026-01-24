class GetCategoriesDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetCategoriesDataModel({this.status, this.message, this.code, this.data});

  GetCategoriesDataModel.fromJson(Map<String, dynamic> json) {
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
  String? title;

  Data({this.id, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
