import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostAskQuestionApi {
  static final PostAskQuestionApi _singleton = PostAskQuestionApi._internal();
  PostAskQuestionApi._internal();

  static PostAskQuestionApi get instance => _singleton;

  Future<Map<String, dynamic>> postAskQuestionApi(int productId, String question) async{
    try{
      Map<String, dynamic> data = {
      'product_id' : productId,
      'question' : question
    };

    Response response = await postHttp(Endpoints.postAskQuestionURL(), data);

    if(response.statusCode == 200){
      final data = response.data;
      return data;
    } else{
      throw DataSource.DEFAULT.getFailure();
    }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  } 
}