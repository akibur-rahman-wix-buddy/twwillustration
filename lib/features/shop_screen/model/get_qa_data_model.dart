class GetQADataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetQADataModel({this.status, this.message, this.code, this.data});

  GetQADataModel.fromJson(Map<String, dynamic> json) {
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
  String? question;
  String? answer;
  bool? isReply;

  Data({this.id, this.question, this.answer, this.isReply});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    isReply = json['is_reply'];
  }
}
