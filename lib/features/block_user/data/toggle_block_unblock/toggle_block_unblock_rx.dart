import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/block_user/data/toggle_block_unblock/toggle_block_unblock_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class ToggleBlockUnblockRx extends RxResponseInt<Map<String, dynamic>>{
  final api = ToggleBlockUnblockApi.instance;

  ToggleBlockUnblockRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getToggleFollowUnfollowData => dataFetcher.stream;

  Future<bool> toggleBlockUnblockRx(int userId) async{
    try{
      Map<String, dynamic> data = await api.toggleBlockUnblockApi(userId);

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