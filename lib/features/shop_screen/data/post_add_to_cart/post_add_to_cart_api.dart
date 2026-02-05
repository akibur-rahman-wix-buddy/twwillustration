import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostAddToCartApi {
  static final PostAddToCartApi _singleton = PostAddToCartApi._internal();
  PostAddToCartApi._internal();

  static PostAddToCartApi get instance => _singleton;

  Future<Map<String, dynamic>> postAddToCartApi(int productId) async{
    try{
      Map<String, dynamic> data = {
        'product_id' : productId
      };

      Response response = await postHttp(Endpoints.postAddTOCartURL(), data);

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('>>>>error during cart api class : $error <<<<');
      rethrow;
    }
  }
}