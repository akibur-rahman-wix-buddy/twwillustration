class GetYourMarketplaceProductModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;
  Pagination? pagination;

  GetYourMarketplaceProductModel(
      {this.status, this.message, this.code, this.data, this.pagination});

  GetYourMarketplaceProductModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? brand;
  String? price;
  String? closetImage;
  String? deliveryStatus;
  dynamic paymentStatus;

  Data(
      {this.id,
      this.title,
      this.brand,
      this.price,
      this.closetImage,
      this.deliveryStatus,
      this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    brand = json['brand'];
    price = json['price'];
    closetImage = json['closet_image'];
    deliveryStatus = json['delivery_status'];
    paymentStatus = json['payment_status'];
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
