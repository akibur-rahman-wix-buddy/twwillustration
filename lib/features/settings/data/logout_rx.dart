import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/settings/data/logout_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostLogoutRx extends RxResponseInt{
  final api = LogoutApi.instance;

  String message = 'Somthing went wrong';

  PostLogoutRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getLogoutData => dataFetcher.stream;

  Future<bool> logout() async{
    try{
      Map resdata = await api.logout();
      return handleSuccessWithReturn(resdata);
    }catch (error){
      return handleErrorWithReturn(error);
    }
  }

    @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    // message = data["message"];
    // if (data["success"] == false) throw Exception();
    log(">>>>>>>>>>>>>>>>>>> Logout success");
    ToastUtil.showShortToast("Logout successful");
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    errorMessage = error.response?.data["message"] ?? "Something went wrong";
    return super.handleErrorWithReturn(errorMessage);
  }
}