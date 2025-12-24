class GetSingleCategoryDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetSingleCategoryDataModel({this.status, this.message, this.code, this.data});

  GetSingleCategoryDataModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  List<Categories>? categories;

  Data({this.id, this.image, this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
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
