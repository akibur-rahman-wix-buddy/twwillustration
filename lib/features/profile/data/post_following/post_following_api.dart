import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostFollowingApi {
  static final PostFollowingApi _singleton = PostFollowingApi._internal();

  PostFollowingApi._internal();

  static PostFollowingApi get instance => _singleton;

  Future<Map<String, dynamic>> postFollowingApi(int id) async{
    try{

      Map<String, dynamic> data ={
        'userId' : id
      };

      Response response = await postHttp(Endpoints.getFollowingURL(), data);

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