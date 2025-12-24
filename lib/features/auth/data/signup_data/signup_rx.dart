import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostSignupRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostSignupAPI.instance;

  PostSignupRX({required super.empty, required super.dataFetcher});

  ValueStream get getFiledData => dataFetcher.stream;

  Future<bool> postSignupRX({
    required dynamic firstName,
    required dynamic lastName,
    required dynamic email,
    required dynamic password,
  }) async {
    try {
      final data = await api.postSignupAPI(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
 
  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    // String token = data['access_token'];
    // dynamic userId = data['data']['id'];
    // dynamic userEmail = data['data']['email'];
    // dynamic userName = data['data']['name'];

    // appData.write(kKeyAccessToken, token);
    // appData.write(kKeyUserID, userId);
    // appData.write(kKeyName, userName);
    // appData.write(kKeyEmail, userEmail);

    // DioSingleton.instance.update(token);

    dataFetcher.sink.add(data);

    return data;

  }

  @override
  handleErrorWithReturn(dynamic error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data["error"]);
      }else{
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }

}
