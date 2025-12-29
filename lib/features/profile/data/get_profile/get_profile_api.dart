import 'package:dio/dio.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetProfileAPI {
  static final GetProfileAPI _singleton = GetProfileAPI._internal();

  GetProfileAPI._internal();

  static GetProfileAPI get instance => _singleton;

  Future<GetProfileDataModel> getProfileAPI() async{
    try{
      Response response = await getHttp(Endpoints.getProfileURL());

      if(response.statusCode == 200){
        final data = response.data;
        // ToastUtil.showShortToast('Get Profile Data');
        return GetProfileDataModel.fromJson(data);
      } else{

        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print("Error during get profile : $error");
      rethrow;
    }
  }
}