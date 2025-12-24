import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/profile/data/edit_profile/edit_profile_api.dart';
import 'package:twwillustration/features/profile/model/edit_profile_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostEditProfileRx extends RxResponseInt<Map<String, dynamic>>{
  final api = PostEditProfileAPI.instance;

  PostEditProfileRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getFiledData => dataFetcher.stream;

  Future<bool> postEditProfileRx(EditProfileModel profile) async{
    try{
      final data = await api.postEditProfileAPI(profile);

      handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    
    dataFetcher.sink.add(data);

    return data;
  }


  @override
  handleErrorWithReturn(error) {
    if(error is DioException){
      ToastUtil.showShortToast(error.response!.data['error']);
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}