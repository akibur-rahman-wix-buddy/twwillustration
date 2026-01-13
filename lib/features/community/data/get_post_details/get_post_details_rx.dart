import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/community/data/get_post_details/get_post_details_api.dart';
import 'package:twwillustration/features/community/model/get_post_details_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetPostDetailsRx extends RxResponseInt<GetPostDetailsDataModel>{
  final api = GetPostDetailsApi.instance;

  GetPostDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream get getPostDetailsData => dataFetcher.stream;

  Future<bool> getPostDEtailsRx(int postId) async{
    try{
      GetPostDetailsDataModel data = await api.getPostDetailsApi(postId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetPostDetailsDataModel data) {
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