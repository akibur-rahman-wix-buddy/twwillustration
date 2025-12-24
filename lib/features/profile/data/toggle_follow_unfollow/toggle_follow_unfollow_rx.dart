import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/profile/data/toggle_follow_unfollow/toggle_follow_unfollow_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class ToggleFollowUnfollowRx extends RxResponseInt<Map<String, dynamic>>{

  final api = ToggleFollowUnfollowApi.instance;

  ToggleFollowUnfollowRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getFollowUnfollowData => dataFetcher.stream;

  Future<bool> toggleFollowUnfollowRx(int id) async{
    try{
      Map<String, dynamic> data = await api.toggleFollowUnfollowApi(id);

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