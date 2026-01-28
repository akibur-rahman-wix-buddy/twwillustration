import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_product/get_marketplace_product_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetMarketplaceProductRx extends RxResponseInt<GetMarketplaceProductModel>{
  final api = GetMarketplaceProductApi.instance;

  GetMarketplaceProductRx({required super.empty, required super.dataFetcher});

  ValueStream get getMarketplaceProductData => dataFetcher.stream;

  Future<bool> getMarketplaceProductRx(String? category, String? search) async{
    try{
      GetMarketplaceProductModel data = await api.getMarketplaceProductApi(category, search);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetMarketplaceProductModel data) {
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