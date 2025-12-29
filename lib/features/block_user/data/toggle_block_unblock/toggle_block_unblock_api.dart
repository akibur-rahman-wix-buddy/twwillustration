import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class ToggleBlockUnblockApi {
  static final ToggleBlockUnblockApi _singleton = ToggleBlockUnblockApi._internal();
  ToggleBlockUnblockApi._internal();

  static ToggleBlockUnblockApi instance = _singleton;

  Future<Map<String, dynamic>> toggleBlockUnblockApi(int userId) async{
    try{
      Response response = await postHttp(Endpoints.toggleBlockUnblockURL(userId));

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }


}