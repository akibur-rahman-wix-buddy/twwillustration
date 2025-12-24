import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class ToggleFollowUnfollowApi {
  static final ToggleFollowUnfollowApi _singleton = ToggleFollowUnfollowApi._internal();

  ToggleFollowUnfollowApi._internal();

  static ToggleFollowUnfollowApi get instance => _singleton;

  Future<Map<String, dynamic>> toggleFollowUnfollowApi(int id) async{
    try{

      Response response = await postHttp(Endpoints.toggleFollowUnfollowURL(id));

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during : $error');
      rethrow;
    }
  }
}