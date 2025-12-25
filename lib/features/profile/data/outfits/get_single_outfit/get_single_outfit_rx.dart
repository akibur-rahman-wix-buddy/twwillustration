import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/profile/data/outfits/get_single_outfit/get_single_outfit_api.dart';
import 'package:twwillustration/features/profile/model/get_single_outfit_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetSingleOutfitRx extends RxResponseInt<GetSingleOutfitDataModel>{
  final api = GetSingleOutfitApi.instance;

  GetSingleOutfitRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getSingleOutfitData => dataFetcher.stream;

  Future<bool> getSingleOutfitRx(int userID, String? category) async{
    try{
      GetSingleOutfitDataModel data = await api.getSingleOutfitApi(userID, category);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetSingleOutfitDataModel data) {
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