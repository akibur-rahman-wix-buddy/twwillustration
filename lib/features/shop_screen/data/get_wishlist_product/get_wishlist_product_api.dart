import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:twwillustration/features/shop_screen/model/get_wishlist_product_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetWishlistProductApi {
  static final GetWishlistProductApi _singleton = GetWishlistProductApi._internal();
  GetWishlistProductApi._internal();

  static GetWishlistProductApi get instance => _singleton;

  Future<GetWishlistProductDataModel> getWishlistProductApi() async{
    try{
      Response response = await getHttp(Endpoints.getWishlistProductURL());
      
      if(response.statusCode == 200){
        final data = response.data;
        return GetWishlistProductDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error >>>>>>>>>>>>>>>>>>');
      rethrow;
    }
  }
}