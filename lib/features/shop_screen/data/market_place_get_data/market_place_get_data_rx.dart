import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/market_place_get_data/market_place_get_data_api.dart';
import 'package:twwillustration/features/shop_screen/model/market_place_get_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class MarketPlaceGetDataRx extends RxResponseInt<MarketPlaceGetDataModel>{
  final api = MarketPlaceGetDataApi.instance;

  MarketPlaceGetDataRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getMarketPlaceData => dataFetcher.stream;

  Future<bool> marketPlaceGetDataRx() async{

    try{
      MarketPlaceGetDataModel data = await api.marketPlaceGetDataApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(MarketPlaceGetDataModel data) {
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