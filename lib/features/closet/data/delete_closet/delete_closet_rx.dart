import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/closet/data/delete_closet/delete_closet_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class DeleteClosetRx extends RxResponseInt<Map<String, dynamic>>{
  final api = DeleteClosetApi.instance;

  DeleteClosetRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getDeleteClosetData => dataFetcher.stream;

  Future<bool> deleteClosetRx(int closetId) async{
    try{
      Map<String, dynamic> data = await api.deleteClosetApi(closetId);

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