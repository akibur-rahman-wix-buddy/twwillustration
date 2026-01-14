import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/community/data/post_comment_like/post_comment_like_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostCommentLikeRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostCommentLikeApi.instance;

  PostCommentLikeRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostCommentLikeData => dataFetcher.stream;

  Future<bool> postCommentLikeRx(int commentId) async{
    try{
      Map<String, dynamic> data = await api.postCommentLikeApi(commentId);

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