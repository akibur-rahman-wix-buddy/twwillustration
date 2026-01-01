import 'dart:typed_data';

class PostAddClosetModel {
  String title;
  List categories;
  String? occation;
  String? brand;
  List<String> colors;
  int materialId;
  String pattern;
  String visibility;
  List? tags;
  DateTime? purchasedDate;
  String? size;
  String? price;
  String? season;
  Uint8List image;

  PostAddClosetModel({
    required this.title,
    required this.categories,
    this.occation,
    this.brand,
    required this.colors,
    required this.materialId,
    required this.pattern,
    required this.visibility,
    this.tags,
    this.purchasedDate,
    this.size,
    this.price,
    this.season,
    required this.image
  });
}