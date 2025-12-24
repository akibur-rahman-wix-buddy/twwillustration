import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/profile/data/clothes/get_single_category/get_single_category_api.dart';
import 'package:twwillustration/features/profile/model/get_single_category_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetSingleCategoryRx extends RxResponseInt<GetSingleCategoryDataModel>{
  final api = GetSingleCategoryApi.instance;

  GetSingleCategoryRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getSingleCategoryData => dataFetcher.stream;

  Future<bool> getSingleCategoryRx(int userID, int? productId) async{
    try{
      GetSingleCategoryDataModel data = await api.getSingleCategoryApi(userID, productId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetSingleCategoryDataModel data) {
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