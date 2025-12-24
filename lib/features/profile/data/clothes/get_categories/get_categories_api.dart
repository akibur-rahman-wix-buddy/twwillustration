import 'package:twwillustration/features/profile/model/get_categories_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetCategoriesApi {
  static final GetCategoriesApi _singleton = GetCategoriesApi._internal();

  GetCategoriesApi._internal();

  static GetCategoriesApi get instance => _singleton;

  Future<GetCategoriesDataModel> getCategoriesApi() async{
    try{
      Response response = await getHttp(Endpoints.getCategoriesURL());

      if(response.statusCode == 200){
        final data = response.data;
        return GetCategoriesDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during : $error');
      rethrow;
    }
  }
}