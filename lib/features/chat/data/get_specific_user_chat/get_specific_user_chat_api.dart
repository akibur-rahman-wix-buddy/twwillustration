import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:twwillustration/features/chat/model/get_specific_user_chat_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetSpecificUserChatApi {
  static final GetSpecificUserChatApi _singleton = GetSpecificUserChatApi._internal();
  GetSpecificUserChatApi._internal();

  static GetSpecificUserChatApi get instance => _singleton;

  Future<GetSpecificUserChatDataModel> getSpecificUserChatApi(int userId) async{
    try{
      Response response = await getHttp(Endpoints.getSpecificUserChatURL(userId));
      
      if(response.statusCode == 200){
        final data = response.data;
        return GetSpecificUserChatDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error >>>>>>>>>>>>>>>>>>');
      rethrow;
    }
  }
}