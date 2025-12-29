class GetListOfPostDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetListOfPostDataModel({this.status, this.message, this.code, this.data});

  GetListOfPostDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? caption;
  String? visibility;
  int? likesCount;
  int? commentsCount;
  String? publishedAt;
  bool? isLiked;
  String? isFollowed;
  User? user;
  Media? media;
  List<Medias>? medias;
  List<Tags>? tags;

  Data(
      {this.id,
      this.caption,
      this.visibility,
      this.likesCount,
      this.commentsCount,
      this.publishedAt,
      this.isLiked,
      this.isFollowed,
      this.user,
      this.media,
      this.medias,
      this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caption = json['caption'];
    visibility = json['visibility'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    publishedAt = json['published_at'];
    isLiked = json['is_liked'];
    isFollowed = json['is_followed'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(Medias.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }
}

class User {
  String? firstName;
  String? lastName;
  String? avatar;

  User({this.firstName, this.lastName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}

class Media {
  String? type;
  String? path;

  Media({this.type, this.path});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    path = json['path'];
  }
}

class Medias {
  String? path;

  Medias({this.path});

  Medias.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }
}

class Tags {
  int? id;
  String? tag;

  Tags({this.id, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }
}
