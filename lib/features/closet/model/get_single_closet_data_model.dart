class GetSingleClosetDataModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetSingleClosetDataModel({this.status, this.message, this.code, this.data});

  GetSingleClosetDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? title;
  String? occasion;
  String? brand;
  Material? material;
  String? pattern;
  List<String>? color;
  String? purchasedDate;
  dynamic price;
  String? size;
  String? season;
  String? visibility;
  String? image;
  List<Categories>? categories;
  List<String>? tags;

  Data(
      {this.id,
      this.title,
      this.occasion,
      this.brand,
      this.material,
      this.pattern,
      this.color,
      this.purchasedDate,
      this.price,
      this.size,
      this.season,
      this.visibility,
      this.image,
      this.categories,
      this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    occasion = json['occasion'];
    brand = json['brand'];
    material = json['material'] != null
        ? Material.fromJson(json['material'])
        : null;
    pattern = json['pattern'];
    color = json['color'].cast<String>();
    purchasedDate = json['purchased_date'];
    price = json['price'];
    size = json['size'];
    season = json['season'];
    visibility = json['visibility'];
    image = json['image'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['tags'] != null) { tags = List<String>.from(json['tags']); 
     }
  }
}

class Material {
  int? id;
  String? name;

  Material({this.id, this.name});

  Material.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Categories {
  int? id;
  String? title;

  Categories({this.id, this.title});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
