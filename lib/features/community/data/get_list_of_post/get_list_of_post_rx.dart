import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/community/data/get_list_of_post/get_list_of_post_api.dart';
import 'package:twwillustration/features/community/model/get_list_of_post_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetListOfPostRx extends RxResponseInt<GetListOfPostDataModel>{
  final api = GetListOfPostApi.instance;

  GetListOfPostRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getListOfPostData => dataFetcher.stream;

  Future<bool> getListOfPostRx(String? search, String? filter) async{

    try{
      GetListOfPostDataModel data = await api.getListOfPostApi(search, filter);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetListOfPostDataModel data) {
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