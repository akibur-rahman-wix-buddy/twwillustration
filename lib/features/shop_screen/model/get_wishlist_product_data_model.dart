class GetWishlistProductDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;
  Pagination? pagination;

  GetWishlistProductDataModel(
      {this.status, this.message, this.code, this.data, this.pagination});

  GetWishlistProductDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Data {
  int? id;
  Product? product;

  Data({this.id, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  String? title;
  String? condition;
  String? price;
  dynamic paymentStatus;
  dynamic deliveryStatus;
  String? image;

  Product(
      {this.id,
      this.title,
      this.condition,
      this.price,
      this.paymentStatus,
      this.deliveryStatus,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    condition = json['condition'];
    price = json['price'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
    image = json['image'];
  }
}

class Pagination {
  int? total;
  int? currentPage;
  int? perPage;
  int? lastPage;
  int? from;
  int? to;

  Pagination(
      {this.total,
      this.currentPage,
      this.perPage,
      this.lastPage,
      this.from,
      this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['current_page'];
    perPage = json['per_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
  }
}
