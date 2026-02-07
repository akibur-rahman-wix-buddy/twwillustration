import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class DeleteCommunityPostApi {
  static final DeleteCommunityPostApi _singleton = DeleteCommunityPostApi._internal();
  DeleteCommunityPostApi._internal();

  static DeleteCommunityPostApi get instance => _singleton;

  Future<Map<String, dynamic>> deleteCommunityPostApi(int postId) async{
    try{
      Response response = await deleteHttp(Endpoints.deleteCommunityPostURL(postId));

      if(response.statusCode == 200){
        final data = response.data;
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    }catch(error){
      print('error during : $error');
      rethrow;
    }
  }
}