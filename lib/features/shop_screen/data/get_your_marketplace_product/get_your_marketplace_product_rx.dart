import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/get_your_marketplace_product/get_your_marketplace_product_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_your_marketplace_product.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetYourMarketplaceProductRx extends RxResponseInt<GetYourMarketplaceProductModel>{
  final api = GetYourMarketplaceProductApi.instance;

  GetYourMarketplaceProductRx({required super.empty, required super.dataFetcher});

  ValueStream get getYourMarketplaceProductData => dataFetcher.stream;

  Future<bool> getYourMarketplaceProductRx() async{
    try{
       GetYourMarketplaceProductModel data = await api.getYourMarketplaceProductApi();

       await handleSuccessWithReturn(data);
       return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetYourMarketplaceProductModel data) {
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