class GetGeneretOutfitFilterDataModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetGeneretOutfitFilterDataModel(
      {this.status, this.message, this.code, this.data});

  GetGeneretOutfitFilterDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<String>? colors;
  List<String>? moods;
  List<String>? occasions;

  Data({this.colors, this.moods, this.occasions});

  Data.fromJson(Map<String, dynamic> json) {
    colors = json['colors'].cast<String>();
    moods = json['moods'].cast<String>();
    occasions = json['occasions'].cast<String>();
  }
}
