import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_wardrobe_product/get_marketplace_wardrobe_product_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_product_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetMarketplaceWardrobeProductRx extends RxResponseInt<GetMarketplaceWardrobeProductDataModel>{
  final api = GetMarketplaceWardrobeProductApi.instance;

  GetMarketplaceWardrobeProductRx({required super.empty, required super.dataFetcher});

  ValueStream get getMarketplaceWardrobeProductData => dataFetcher.stream;

  Future<bool> getMarketplaceWardrobeProductRx(String? type) async{
    try{
      GetMarketplaceWardrobeProductDataModel data = await api.getMarketplaceWardrobeProductApi(type);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetMarketplaceWardrobeProductDataModel data) {
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