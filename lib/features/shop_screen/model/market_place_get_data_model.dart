class MarketPlaceGetDataModel {
  bool? status;
  String? message;
  int? code;
  CategoriesPayload? data;

  MarketPlaceGetDataModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  MarketPlaceGetDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null
        ? CategoriesPayload.fromJson(json['data'])
        : null;
  }
}

class CategoriesPayload {
  List<Category>? categories;
  List<Condition>? conditions;

  CategoriesPayload({
    this.categories,
    this.conditions,
  });

  CategoriesPayload.fromJson(Map<String, dynamic> json) {
    categories = (json['categories'] as List?)
        ?.map((e) => Category.fromJson(e))
        .toList();

    conditions = (json['conditions'] as List?)
        ?.map((e) => Condition.fromJson(e))
        .toList();
  }
}

class Category {
  int? id;
  String? title;

  Category({
    this.id,
    this.title,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class Condition {
  String? name;
  String? value;

  Condition({
    this.name,
    this.value,
  });

  Condition.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }
}

