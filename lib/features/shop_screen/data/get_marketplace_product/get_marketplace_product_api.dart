import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_product_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetMarketplaceProductApi {
  static final GetMarketplaceProductApi _singleton = GetMarketplaceProductApi._internal();
  GetMarketplaceProductApi._internal();

  static GetMarketplaceProductApi get instance => _singleton;

  Future<GetMarketplaceProductModel> getMarketplaceProductApi(String? category, String? search) async{
    try{
      Response response = await getHttp(Endpoints.getMarketplaceProductURL(category, search));

      if(response.statusCode == 200){
        final data = response.data;
        return GetMarketplaceProductModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}