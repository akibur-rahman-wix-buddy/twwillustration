import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/post_ask_question/post_ask_question_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostAskQuestionRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostAskQuestionApi.instance;

  PostAskQuestionRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostAskQuestionData => dataFetcher.stream;

  Future<bool> postAskQuestionRx(int productId, String question) async{
    try{
      Map<String, dynamic> data = await api.postAskQuestionApi(productId, question);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {

    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}