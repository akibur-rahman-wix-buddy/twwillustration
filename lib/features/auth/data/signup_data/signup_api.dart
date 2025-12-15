
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final  class PostSignupAPI{
  static final PostSignupAPI _singleton = PostSignupAPI._internal();

  PostSignupAPI._internal();

  static PostSignupAPI get instance => _singleton;

  Future<Map<String, dynamic>> postSignupAPI({
    required dynamic firstName,
    required dynamic lastName,
    required dynamic email,
    required dynamic password

  }) async{
    try{
      Map<String, dynamic> data = {
        'first_name' : firstName,
        'last_name' : lastName,
        'email' : email,
        'password' : password
      };

      Response response = (await postHttp(Endpoints.signUpUrl(), data));

      if(response.statusCode == 200){
        final data = jsonDecode(jsonEncode(response.data));
        ToastUtil.showShortToast("A verification code has been sent to your email address.7415");
        return data;
      }else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during signup: $error');
      rethrow;
    }
  }
}