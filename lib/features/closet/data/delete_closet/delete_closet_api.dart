import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class DeleteClosetApi {
  static final DeleteClosetApi _singleton = DeleteClosetApi._internal();
  DeleteClosetApi._internal();

  static DeleteClosetApi get instance => _singleton;

  Future<Map<String, dynamic>> deleteClosetApi(int closetId) async{
    try{
      Response response = await deleteHttp(Endpoints.deleteClosetURL(closetId));

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