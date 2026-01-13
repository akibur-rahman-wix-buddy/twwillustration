import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/community/data/add_post/post_add_post_api.dart';
import 'package:twwillustration/features/community/model/post_add_post_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostAddPostRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostAddPostApi.instance;

  PostAddPostRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getPostAddPostData => dataFetcher.stream;

  Future<bool> postAddPostRx(PostAddPostDataModel post) async{
    try{
      Map<String, dynamic> data = await api.postAddPostApi(post);

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
    // Handle API error using DioException
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