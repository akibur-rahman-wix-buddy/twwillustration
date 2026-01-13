class GetPostDetailsDataModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  GetPostDetailsDataModel({this.status, this.message, this.code, this.data});

  GetPostDetailsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<Comments>? comments;

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
      this.tags,
      this.comments});

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
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;

  User({this.id, this.firstName, this.lastName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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

class Comments {
  int? id;
  String? comment;
  int? postId;
  int? parentId;
  String? createdAt;
  User? user;
  List<Replies>? replies;
  bool? isLiked;

  Comments(
      {this.id,
      this.comment,
      this.postId,
      this.parentId,
      this.createdAt,
      this.user,
      this.replies,
      this.isLiked});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    postId = json['post_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
  }
}

class Replies {
  int? id;
  String? comment;
  int? postId;
  int? parentId;
  String? createdAt;
  User? user;
  List<Replies>? replies; 
  bool? isLiked;

  Replies({
    this.id,
    this.comment,
    this.postId,
    this.parentId,
    this.createdAt,
    this.user,
    this.replies,
    this.isLiked,
  });

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    postId = json['post_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isLiked = json['is_liked'];

    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v)); 
      });
    }
  }
}

