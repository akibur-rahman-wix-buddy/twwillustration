import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_filters_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetMarketplaceWardrobeFiltersApi {
  static final GetMarketplaceWardrobeFiltersApi _singleton = GetMarketplaceWardrobeFiltersApi._internal();
  GetMarketplaceWardrobeFiltersApi._internal();

  static GetMarketplaceWardrobeFiltersApi get instance => _singleton;

  Future<GetMatketplaceWardrobeFiltersDataModel> getMarketplaceWardrobeFiltersApi() async{
    try{
      Response response = await getHttp(Endpoints.getMarketplacrWardrobeFiltersURL());

      if(response.statusCode == 200){
        final data = response.data;
        return GetMatketplaceWardrobeFiltersDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}