import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetSingleCategoryApi {
  static final GetSingleCategoryApi _singleton = GetSingleCategoryApi._internal();

  GetSingleCategoryApi._internal();

  static GetSingleCategoryApi get instance => _singleton;

  Future<GetSingleCategoryDataModel> getSingleCategoryApi(int userID, int? productId) async{
    try{
      Response response = await getHttp(Endpoints.getSingleCategoriesURl(userID, productId));

      if(response.statusCode == 200){
        final data = response.data;
        return GetSingleCategoryDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during : $error');
      rethrow;
    }
  }
}