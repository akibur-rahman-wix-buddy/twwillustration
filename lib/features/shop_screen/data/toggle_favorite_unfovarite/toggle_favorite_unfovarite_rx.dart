import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/toggle_favorite_unfovarite/toggle_favorite_unfovarite_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class ToggleFavoriteUnfovariteRx extends RxResponseInt<Map<String, dynamic>>{
  final api = ToggleFavoriteUnfovariteApi.instance;

  ToggleFavoriteUnfovariteRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getToggleFavoriteUnfovariteData => dataFetcher.stream;

  Future<bool> toggleFavoriteUnfovariteRx(int productId) async{
    try{
      Map<String, dynamic> data = await api.toggleFavoriteUnfovariteApi(productId);

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