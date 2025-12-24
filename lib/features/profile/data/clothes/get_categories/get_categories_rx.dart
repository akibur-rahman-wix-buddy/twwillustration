import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/profile/data/clothes/get_categories/get_categories_api.dart';
import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetCategoriesRx extends RxResponseInt<GetCategoriesDataModel>{
  final api = GetCategoriesApi.instance;

  GetCategoriesRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getCategoriesData => dataFetcher.stream;

  Future<bool> getCategoriesRx() async{
    try{
      GetCategoriesDataModel data = await api.getCategoriesApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetCategoriesDataModel data) {
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