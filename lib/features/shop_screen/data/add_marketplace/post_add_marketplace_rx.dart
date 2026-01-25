import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/shop_screen/data/add_marketplace/post_add_marketplace_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostAddMarketplaceRx extends RxResponseInt{
  final api = PostAddMarketplaceApi.instance;

  PostAddMarketplaceRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostMarketPlaceData => dataFetcher.stream;

  Future<bool> postAddMarketplaceRx({
    required dynamic productId,
    required List<String> images,
    required dynamic title,
    required dynamic description,
    required dynamic category,
    required dynamic size,
    required dynamic brand,
    required dynamic condition,
    required dynamic price,
    required dynamic shippingOption,
  }) async{
    try{
      Map<String, dynamic> data = await api.postAddMarketplaceApi(productId: productId, images: images, title: title, description: description, category: category, size: size, brand: brand, condition: condition, price: price, shippingOption: shippingOption);
      
      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);}
  }

  @override
  handleSuccessWithReturn(dynamic data) {
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}