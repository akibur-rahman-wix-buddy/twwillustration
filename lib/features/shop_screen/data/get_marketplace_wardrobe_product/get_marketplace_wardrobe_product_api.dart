import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_product_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetMarketplaceWardrobeProductApi {
  static final GetMarketplaceWardrobeProductApi _singleton = GetMarketplaceWardrobeProductApi._internal();
  GetMarketplaceWardrobeProductApi._internal();

  static GetMarketplaceWardrobeProductApi get instance => _singleton;

  Future<GetMarketplaceWardrobeProductDataModel> getMarketplaceWardrobeProductApi(String? type) async{
    try{
      Response response = await getHttp(Endpoints.getMarketplaceWardrobeProductURL(type));

      if(response.statusCode == 200){
        final data = response.data;
        return GetMarketplaceWardrobeProductDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}