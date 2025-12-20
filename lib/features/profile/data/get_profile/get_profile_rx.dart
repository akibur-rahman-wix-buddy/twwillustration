import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/profile/data/get_profile/get_profile_api.dart';
import 'package:twwillustration/features/profile/model/get_profile_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetProfileRx extends RxResponseInt<GetProfileDataModel>{
  final api = GetProfileAPI.instance;

  GetProfileRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getProfileData => dataFetcher.stream;

  Future<bool> getProfileRx() async{
    try{
      GetProfileDataModel data = await api.getProfileAPI();

      await handleSuccessWithReturn(data);
      return true;
    } catch (error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetProfileDataModel data) {
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