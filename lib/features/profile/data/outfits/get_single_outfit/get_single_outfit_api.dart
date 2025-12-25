import 'package:twwillustration/features/profile/model/get_single_outfit_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetSingleOutfitApi {
  static final GetSingleOutfitApi _singleton = GetSingleOutfitApi._internal();

  GetSingleOutfitApi._internal();

  static GetSingleOutfitApi get instance => _singleton;

  Future<GetSingleOutfitDataModel> getSingleOutfitApi(int userID, String? category) async{
    try{
      Response response = await getHttp(Endpoints.getSingleOutfitesURL(userID, category));

      if(response.statusCode == 200){
        final data = response.data;
        return GetSingleOutfitDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during : $error');
      rethrow;
    }
  }
}