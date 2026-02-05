class GetMarketplaceWardrobeProductDataModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetMarketplaceWardrobeProductDataModel(
      {this.status, this.message, this.code, this.data});

  GetMarketplaceWardrobeProductDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<AllClosets>? allClosets;
  List<AllClosets>? lessUsedClosets;

  Data({this.allClosets, this.lessUsedClosets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['allClosets'] != null) {
      allClosets = <AllClosets>[];
      json['allClosets'].forEach((v) {
        allClosets!.add(AllClosets.fromJson(v));
      });
    }
    if (json['lessUsedClosets'] != null) {
      lessUsedClosets = <AllClosets>[];
      json['lessUsedClosets'].forEach((v) {
        lessUsedClosets!.add(AllClosets.fromJson(v));
      });
    }
  }
}

class AllClosets {
  int? id;
  String? title;
  List<String>? color;
  int? worn;
  String? image;

  AllClosets({this.id, this.title, this.color, this.worn, this.image});

  AllClosets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'].cast<String>();
    worn = json['worn'];
    image = json['image'];
  }
}
