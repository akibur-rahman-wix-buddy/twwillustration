import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/post_add_to_cart/post_add_to_cart_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostAddToCartRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostAddToCartApi.instance;

  PostAddToCartRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostAddToCartata => dataFetcher.stream;

  Future<bool> postAddToCartRx(int productId) async{
    try{

      Map<String, dynamic> data = await api.postAddToCartApi(productId);

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
  handleErrorWithReturn(dynamic error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data['error']);
      } else{
        ToastUtil.showShortToast(error.response!.data['error']);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}