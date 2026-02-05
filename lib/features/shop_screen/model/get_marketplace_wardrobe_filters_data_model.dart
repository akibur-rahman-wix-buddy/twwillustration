class GetMatketplaceWardrobeFiltersDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetMatketplaceWardrobeFiltersDataModel(
      {this.status, this.message, this.code, this.data});

  GetMatketplaceWardrobeFiltersDataModel.fromJson(Map<String, dynamic> json) {
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
  String? type;

  Data({this.type});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }
}
