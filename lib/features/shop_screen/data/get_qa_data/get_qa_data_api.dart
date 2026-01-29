import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:twwillustration/features/shop_screen/model/get_qa_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetQaDataApi {
  static final GetQaDataApi _singleton = GetQaDataApi._internal();
  GetQaDataApi._internal();

  static GetQaDataApi get instance => _singleton;

  Future<GetQADataModel> getQaDataApi(int productId) async{
    try{
      Response response = await getHttp(Endpoints.getQADataURL(productId));

      if(response.statusCode == 200){
        final data = response.data;
        return GetQADataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error');
      rethrow;
    }
  }
}