import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:twwillustration/features/shop_screen/model/get_your_marketplace_product.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetYourMarketplaceProductApi {
  static final GetYourMarketplaceProductApi _singleton = GetYourMarketplaceProductApi._internal();
  GetYourMarketplaceProductApi._internal();

  static GetYourMarketplaceProductApi get instance => _singleton;

  Future<GetYourMarketplaceProductModel> getYourMarketplaceProductApi() async{
    try{
      Response response = await getHttp(Endpoints.getYourMarketplaceProductURL());

      if(response.statusCode == 200){
        final data = response.data;
        return GetYourMarketplaceProductModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}