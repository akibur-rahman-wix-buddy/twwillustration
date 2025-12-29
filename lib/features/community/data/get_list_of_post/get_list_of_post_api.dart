import 'package:dio/dio.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetListOfPostApi {

  static final GetListOfPostApi _singleton = GetListOfPostApi._internal();

  GetListOfPostApi._internal();

  static GetListOfPostApi get instance => _singleton;

  Future<GetListOfPostDataModel> getListOfPostApi(String? search, String? filter) async{

    try{
      Response response = await getHttp(Endpoints.getListOfPostURL(search, filter));

      if(response.statusCode == 200){
        final data = response.data;
        return GetListOfPostDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }

  
}