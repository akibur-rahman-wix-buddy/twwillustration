import 'package:dio/dio.dart';
import 'package:twwillustration/features/closet/model/get_materilas_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetMaterialsApi {
  static final GetMaterialsApi _singleton = GetMaterialsApi._internal();
  GetMaterialsApi._internal();

  static GetMaterialsApi get instance => _singleton;

  Future<GetMaterialsDataModel> getMaterialsApi() async{
    try{
      Response response = await getHttp(Endpoints.getMaterialsURL());
      
      if(response.statusCode == 200){
        final data = response.data;
        return GetMaterialsDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('error during : $error >>>>>>>>>>>>>>>>>>');
      rethrow;
    }
  }
}