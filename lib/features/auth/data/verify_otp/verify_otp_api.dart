
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostVerifyOTPAPI {
  static final PostVerifyOTPAPI _singleton = PostVerifyOTPAPI._internal();

  PostVerifyOTPAPI._internal();

  static PostVerifyOTPAPI get instance => _singleton;

  Future<Map<String, dynamic>> postVerifyOTPAPI({
    required dynamic email,
    required dynamic otp
  }) async {
    try{
      Map<String, dynamic> data = {
        'email' : email,
        'otp' : otp
      };

      Response response = await postHttp(Endpoints.verifyOtpUrl(), data);

      if(response.statusCode == 200){
        final data = jsonDecode(jsonEncode(response.data));
        ToastUtil.showShortToast('Verification successfull please login');
        return data;
      }else{
        // String message = data['message'];
        // ToastUtil.showShortToast(message);
        throw DataSource.DEFAULT.getFailure();
      }
    }catch(e){
      print('Error : $e');
      rethrow;
    }
  }

}