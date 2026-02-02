import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:twwillustration/features/chat/model/get_chat_list_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class GetChatListApi {
  static final GetChatListApi _singleton = GetChatListApi._internal();
  GetChatListApi._internal();

  static GetChatListApi get instance => _singleton;

  Future<GetChatListDataModel> getChatListApi(String? search) async{
    try{
      Response response = await getHttp(Endpoints.getChatListURL(search));
      
      if(response.statusCode == 200){
        final data = response.data;
        return GetChatListDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      debugPrint('error during : $error >>>>>>>>>>>>>>>>>>');
      rethrow;
    }
  }
}