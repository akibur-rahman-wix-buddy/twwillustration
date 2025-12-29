import 'package:dio/dio.dart';
import 'package:twwillustration/features/FAQ/model/get_faq_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetFaqApi {
  static final GetFaqApi _singleton = GetFaqApi._internal();
  GetFaqApi._internal();

  static GetFaqApi get instance => _singleton;

  Future<GetFAQDataModel> getFaqApi() async{
    try{
      Response response = await getHttp(Endpoints.getFAQURL());

      if(response.statusCode == 200){
        final data = response.data;
        return GetFAQDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('error during: $error');
      rethrow;
    }
  }
}
