import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/get_qa_data/get_qa_data_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_qa_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetQaDataRx extends RxResponseInt<GetQADataModel>{
  final api = GetQaDataApi.instance;

  GetQaDataRx({required super.empty, required super.dataFetcher});

  ValueStream get getGetQaData => dataFetcher.stream;

  Future<bool> getQaDataRx(int productId) async{
    try{
      GetQADataModel data = await api.getQaDataApi(productId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetQADataModel data) {
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