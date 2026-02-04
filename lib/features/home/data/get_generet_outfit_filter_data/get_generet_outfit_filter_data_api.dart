import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:twwillustration/features/home/model/get_generet_outfit_filter_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetGeneretOutfitFilterDataApi {
  static final GetGeneretOutfitFilterDataApi _singleton = GetGeneretOutfitFilterDataApi._internal();
  GetGeneretOutfitFilterDataApi._internal();


  static GetGeneretOutfitFilterDataApi get instance => _singleton;

  Future<GetGeneretOutfitFilterDataModel> getGeneretOutfitFilterDataApi() async{
    try{
      Response response = await getHttp(Endpoints.getGeneretOutfitDataURL());

      if(response.statusCode == 200){
        final data = response.data;
        return GetGeneretOutfitFilterDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('>>>>>>>>error during getGentratedOutfitFilter data api class : $error<<<<<');
      rethrow;
    }
  }
}