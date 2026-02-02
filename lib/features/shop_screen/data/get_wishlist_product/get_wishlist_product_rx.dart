import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/get_wishlist_product/get_wishlist_product_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_wishlist_product_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetWishlistProductRx extends RxResponseInt<GetWishlistProductDataModel>{
  final api = GetWishlistProductApi.instance;

  GetWishlistProductRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get gettWishlistProductData => dataFetcher.stream;

  Future<bool> gettWishlistProductRx() async{
    try{
      GetWishlistProductDataModel data = await api.getWishlistProductApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetWishlistProductDataModel data) {
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