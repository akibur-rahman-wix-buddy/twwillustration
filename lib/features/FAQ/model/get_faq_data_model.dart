class GetFAQDataModel {
  bool? status;
  String? message;
  int? code;
  List<Data>? data;

  GetFAQDataModel({this.status, this.message, this.code, this.data});

  GetFAQDataModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.question, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}

