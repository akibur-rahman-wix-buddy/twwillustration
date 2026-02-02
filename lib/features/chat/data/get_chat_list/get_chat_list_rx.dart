import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/chat/data/get_chat_list/get_chat_list_api.dart';
import 'package:twwillustration/features/chat/model/get_chat_list_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetChatListRx extends RxResponseInt<GetChatListDataModel>{
  final api = GetChatListApi.instance;

  GetChatListRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getMaterialsData => dataFetcher.stream;

  Future<bool> getChatListRx(String? search) async{
    try{
      GetChatListDataModel data = await api.getChatListApi(search);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetChatListDataModel data) {
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