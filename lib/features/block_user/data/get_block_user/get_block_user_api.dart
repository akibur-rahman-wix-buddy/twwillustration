import 'package:dio/dio.dart';
import 'package:twwillustration/features/block_user/model/get_block_user_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetBlockUserApi {
  static final GetBlockUserApi _singleton = GetBlockUserApi._internal();
  GetBlockUserApi._internal();


  static GetBlockUserApi instance = _singleton;

  Future<GetBlockUserDataModel> getBlockUserApi(String? search) async {
    try{
      Response response = await getHttp(Endpoints.getBlockUsreURl(search));

      if(response.statusCode == 200){
        final data = response.data;
        return GetBlockUserDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('error during: $error');
      rethrow;
    }
  }
}