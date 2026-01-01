import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/closet/data/get_materials/get_materials_api.dart';
import 'package:twwillustration/features/closet/model/get_materilas_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetMaterialsRx extends RxResponseInt<GetMaterialsDataModel>{
  final api = GetMaterialsApi.instance;

  GetMaterialsRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getMaterialsData => dataFetcher.stream;

  Future<bool> getMaterialsRx() async{
    try{
      GetMaterialsDataModel data = await api.getMaterialsApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetMaterialsDataModel data) {
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