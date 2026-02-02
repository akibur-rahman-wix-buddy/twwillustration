import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostAskQuestionReplayApi {
  static final PostAskQuestionReplayApi _singleton = PostAskQuestionReplayApi._internal();
  PostAskQuestionReplayApi._internal();

  static PostAskQuestionReplayApi get instance => _singleton;

  Future<Map<String, dynamic>> postAskQuestionReplayApi(int questionId, String answer) async{
    try{
      Map<String, dynamic> data = {
      'question_id' : questionId,
      'answer' : answer
    };

    Response response = await postHttp(Endpoints.postAskQuestionReplayURL(), data);

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