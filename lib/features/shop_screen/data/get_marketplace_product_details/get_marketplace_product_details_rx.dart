import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_product_details/get_marketplace_product_details_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_details_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetMarketplaceProductDetailsRx extends RxResponseInt{
  final api = GetMarketplaceProductDetailsApi.instance;

  GetMarketplaceProductDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream get getMarketplaceProductDetailsData => dataFetcher.stream;

  Future<bool> getMarketplaceProductDetailsRx(int productId) async{
    try{
      GetMarketplaceProductDetailsModel data = await api.getMarketplaceProductDetailsApi(productId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(dynamic data) {
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