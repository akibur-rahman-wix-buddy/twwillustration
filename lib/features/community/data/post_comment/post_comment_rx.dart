import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/community/data/post_comment/post_comment_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostCommentRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostCommentApi.instance;

  PostCommentRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostCommentData => dataFetcher.stream;

  Future<bool> postCommentRx(int postId, int? parentId, String comment) async{
    try{
      Map<String, dynamic> data = await api.postCommentApi(postId, parentId, comment);

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