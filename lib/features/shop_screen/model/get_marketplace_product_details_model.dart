class GetMarketplaceProductDetailsModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetMarketplaceProductDetailsModel(
      {this.status, this.message, this.code, this.data});

  GetMarketplaceProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Product? product;
  List<RelatedProducts>? relatedProducts;

  Data({this.product, this.relatedProducts});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['related_products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['related_products'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  String? title;
  int? userId;
  String? description;
  String? condition;
  String? price;
  String? size;
  String? brand;
  String? category;
  String? shippingOption;
  dynamic paymentStatus;
  dynamic deliveryStatus;
  List<String>? images;
  int? pastOutfitDiaryCount;
  bool? isFav;
  bool? isAlreadyChat;

  Product(
      {this.id,
      this.title,
      this.userId,
      this.description,
      this.condition,
      this.price,
      this.size,
      this.brand,
      this.category,
      this.shippingOption,
      this.paymentStatus,
      this.deliveryStatus,
      this.images,
      this.pastOutfitDiaryCount,
      this.isFav,
      this.isAlreadyChat});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    description = json['description'];
    condition = json['condition'];
    price = json['price'];
    size = json['size'];
    brand = json['brand'];
    category = json['category'];
    shippingOption = json['shipping_option'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
    images = json['images'].cast<String>();
    pastOutfitDiaryCount = json['past_outfit_diary_count'];
    isFav = json['isFav'];
    isAlreadyChat = json['isAlreadyChat'];
  }
}

class RelatedProducts {
  int? id;
  String? title;
  String? condition;
  String? price;
  dynamic paymentStatus;
  dynamic deliveryStatus;
  String? image;
  int? pastOutfitDiaryCount;
  bool? isFav;

  RelatedProducts(
      {this.id,
      this.title,
      this.condition,
      this.price,
      this.paymentStatus,
      this.deliveryStatus,
      this.image,
      this.pastOutfitDiaryCount,
      this.isFav});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    condition = json['condition'];
    price = json['price'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
    image = json['image'];
    pastOutfitDiaryCount = json['past_outfit_diary_count'];
    isFav = json['isFav'];
  }
}
