import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostFollowerApi {
  static final PostFollowerApi _singleton = PostFollowerApi._internal();

  PostFollowerApi._internal();

  static PostFollowerApi get instance => _singleton;

  Future<Map<String, dynamic>> postFollowerApi(int id) async{
    try{

      Map<String, dynamic> data ={
        'userId' : id
      };

      Response response = await postHttp(Endpoints.getFollowerURL(), data);

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