import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostCommentApi {
  static final PostCommentApi _singleton = PostCommentApi._internal();
  PostCommentApi._internal();

  static PostCommentApi get instance => _singleton;

  Future<Map<String, dynamic>> postCommentApi(int postId, int? parentId, String comment) async{
    try{
      Map<String, dynamic> data = {
        'parent_id' : parentId,
        'comment' : comment
      };

      Response response = await postHttp(Endpoints.postCommentURL(postId), data);

      if(response.statusCode == 200){
        final data = jsonDecode(jsonEncode(response.data));
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }
}