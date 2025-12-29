import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class ToggleLikeUnlikeApi {
  static final ToggleLikeUnlikeApi _singleton = ToggleLikeUnlikeApi._internal();

  ToggleLikeUnlikeApi._internal();

  static ToggleLikeUnlikeApi get instance => _singleton;

  Future<Map<String, dynamic>> toggleLikeUnlikeApi(int postId) async{
    try{
      Response response = await postHttp(Endpoints.toggleLikeUnlikeURL(postId));

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }
}