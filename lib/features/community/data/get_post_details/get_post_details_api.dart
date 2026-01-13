import 'package:dio/dio.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetPostDetailsApi {
  static final GetPostDetailsApi _singleton = GetPostDetailsApi._internal();
  GetPostDetailsApi._internal();

  static GetPostDetailsApi get instance => _singleton;

  Future<GetPostDetailsDataModel> getPostDetailsApi(int postId) async{
    try{
      Response response = await getHttp(Endpoints.getPostDetailsURL(postId));

      if(response.statusCode == 200){
        final data = response.data;
        return GetPostDetailsDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }
}