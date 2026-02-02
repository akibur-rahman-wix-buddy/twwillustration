import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/chat/data/get_specific_user_chat/get_specific_user_chat_api.dart';
import 'package:twwillustration/features/chat/model/get_specific_user_chat_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetSpecificUserChatRx extends RxResponseInt<GetSpecificUserChatDataModel>{
  final api = GetSpecificUserChatApi.instance;

  GetSpecificUserChatRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getMaterialsData => dataFetcher.stream;

  Future<bool> getChatListRx(int userId) async{
    try{
      GetSpecificUserChatDataModel data = await api.getSpecificUserChatApi(userId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetSpecificUserChatDataModel data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else{
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}