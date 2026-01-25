import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_details_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetMarketplaceProductDetailsApi {
  static final GetMarketplaceProductDetailsApi _singleton = GetMarketplaceProductDetailsApi._internal();
  GetMarketplaceProductDetailsApi._internal();

  static GetMarketplaceProductDetailsApi get instance => _singleton;

  Future<GetMarketplaceProductDetailsModel> getMarketplaceProductDetailsApi(int productId) async{
    try{
      Response response = await getHttp(Endpoints.getMarketplaceProductDetailsURL(productId));

      if(response.statusCode == 200){
        final data = response.data;
        return GetMarketplaceProductDetailsModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}