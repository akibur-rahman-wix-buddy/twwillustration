import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/closet/data/update_closet/update_closet_api.dart';
import 'package:twwillustration/features/closet/model/update_closet_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class UpdateClosetRx extends RxResponseInt<Map<String, dynamic>>{
  final api = UpdateClosetApi.instance;

  UpdateClosetRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getUpdateClosetData  => dataFetcher.stream;

  Future<bool> updateClosetRx(PostUpdateClosetModel closet, int closetId) async{
    try{
      final data = await api.updateClosetApi(closet, closetId);

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