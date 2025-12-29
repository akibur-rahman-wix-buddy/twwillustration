import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/community/data/toggle_like_unlike/toggle_like_unlike_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class ToggleLikeUnlikeRx extends RxResponseInt<Map<String, dynamic>>{
  final api = ToggleLikeUnlikeApi.instance;

  ToggleLikeUnlikeRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getToggleLikeUnlikeData => dataFetcher.stream;

  Future<bool> toggleLikeUnlikeRx(int postId) async{
    try{
      Map<String, dynamic> data = await api.toggleLikeUnlikeApi(postId);

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
  handleErrorWithReturn(error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else{
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}