import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/block_user/data/get_block_user/get_block_user_api.dart';
import 'package:twwillustration/features/block_user/model/get_block_user_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetBlockUserRx extends RxResponseInt<GetBlockUserDataModel>{
  final api = GetBlockUserApi.instance;

  GetBlockUserRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getBlockUserData => dataFetcher.stream;

  Future<bool> getBlockUserRx(String? search) async{
    try{
      GetBlockUserDataModel data = await api.getBlockUserApi(search);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetBlockUserDataModel data) {
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