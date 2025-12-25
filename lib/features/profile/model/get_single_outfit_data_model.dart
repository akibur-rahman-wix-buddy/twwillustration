class GetSingleOutfitDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetSingleOutfitDataModel({this.status, this.message, this.code, this.data});

  GetSingleOutfitDataModel.fromJson(Map<String, dynamic> json) {
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
  String? occasion;
  String? bgColor;
  List<Closets>? closets;

  Data({this.id, this.occasion, this.bgColor, this.closets});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    occasion = json['occasion'];
    bgColor = json['bg_color'];
    if (json['closets'] != null) {
      closets = <Closets>[];
      json['closets'].forEach((v) {
        closets!.add(new Closets.fromJson(v));
      });
    }
  }
}

class Closets {
  int? id;
  String? image;
  List<Categories>? categories;

  Closets({this.id, this.image, this.categories});

  Closets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? title;
  String? type;

  Categories({this.id, this.title, this.type});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
  }
}
