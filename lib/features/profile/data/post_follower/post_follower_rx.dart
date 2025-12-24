import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/profile/data/post_follower/post_follower_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostFollowerRx extends RxResponseInt<Map<String, dynamic>>{

  final api = PostFollowerApi.instance;

  PostFollowerRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getFollowerData => dataFetcher.stream;

  Future<bool> postFollowerRx(int id) async{
    try{
      Map<String, dynamic> data = await api.postFollowerApi(id);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return handleErrorWithReturn(error);
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