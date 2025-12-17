import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class LogoutApi {

  static final LogoutApi _singleton = LogoutApi._internal();
  LogoutApi._internal();

  static LogoutApi get instance => _singleton;

  Future<Map> logout() async{
    try{
      Response response = await postHttp(Endpoints.logOutUrl());

      if(response.statusCode == 200){
        Map data = jsonDecode(jsonEncode(response.data));
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    }catch(error){
      rethrow;
    }
  }
}