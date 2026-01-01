import 'package:dio/dio.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetSingleClosetApi {
  static final GetSingleClosetApi _singleton = GetSingleClosetApi._internal();
  GetSingleClosetApi._internal();

  static GetSingleClosetApi get instance => _singleton;

  Future<GetSingleClosetDataModel> getSingleClosetApi(int closetId) async{
    try{

      Response response = await getHttp(Endpoints.getSingleClosetURl(closetId));

      if(response.statusCode == 200){
        final data = response.data;
        return GetSingleClosetDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('error during : $error');
      rethrow;
    }
  }
}