import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/closet/data/get_single_closet/get_single_closet_api.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetSingleClosetRx extends RxResponseInt<GetSingleClosetDataModel>{
  final api = GetSingleClosetApi.instance;

  GetSingleClosetRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getSingleClosetData => dataFetcher.stream;

  Future<bool> getSingleClosetRx(int closetId) async{
    try{
      GetSingleClosetDataModel data = await api.getSingleClosetApi(closetId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetSingleClosetDataModel data) {
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