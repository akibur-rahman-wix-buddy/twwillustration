import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/FAQ/data/get_faq_api.dart';
import 'package:twwillustration/features/FAQ/model/get_faq_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetFaqRx extends RxResponseInt<GetFAQDataModel>{
  final api = GetFaqApi.instance;

  GetFaqRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getFaqData => dataFetcher.stream;

  Future<bool> getFaqRx() async{
    try{
      GetFAQDataModel data = await api.getFaqApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

   @override
  handleSuccessWithReturn(GetFAQDataModel data) {
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