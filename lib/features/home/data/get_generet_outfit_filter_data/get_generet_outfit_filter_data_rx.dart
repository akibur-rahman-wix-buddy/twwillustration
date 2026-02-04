import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/home/data/get_generet_outfit_filter_data/get_generet_outfit_filter_data_api.dart';
import 'package:twwillustration/features/home/model/get_generet_outfit_filter_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetGeneretOutfitFilterDataRx extends RxResponseInt<GetGeneretOutfitFilterDataModel>{
  final api = GetGeneretOutfitFilterDataApi.instance;

  GetGeneretOutfitFilterDataRx({required super.empty, required super.dataFetcher});

  ValueStream get getGeneratedOutfitFilterData => dataFetcher.stream;

  Future<bool> getGeneretOutfitFilterDataRx() async{
    try{
      GetGeneretOutfitFilterDataModel data = await api.getGeneretOutfitFilterDataApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetGeneretOutfitFilterDataModel data){
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data['message']);
      } else{
        ToastUtil.showShortToast(error.response!.data['message']);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}