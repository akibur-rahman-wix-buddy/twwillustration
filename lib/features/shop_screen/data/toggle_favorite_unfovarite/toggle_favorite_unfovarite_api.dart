import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class ToggleFavoriteUnfovariteApi {
  static final ToggleFavoriteUnfovariteApi _singleton = ToggleFavoriteUnfovariteApi._internal();

  ToggleFavoriteUnfovariteApi._internal();

  static ToggleFavoriteUnfovariteApi get instance => _singleton;

  Future<Map<String, dynamic>> toggleFavoriteUnfovariteApi(int productId) async{
    try{
      Map<String, dynamic> data = {
        'product_id' : productId
      };
      Response response = await postHttp(Endpoints.toggleProductFavoriteUnfovartieURL(), data);

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during $error');
      rethrow;
    }
  }
}