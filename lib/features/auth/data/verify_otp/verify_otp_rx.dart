import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/auth/data/verify_otp/verify_otp_api.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostVerifyOtpRx extends RxResponseInt<Map<String, dynamic>> {

  final api = PostVerifyOTPAPI.instance;

  PostVerifyOtpRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getFiledData => dataFetcher.stream;

  Future<bool> postVerifyRX({
    required dynamic email,
    required dynamic otp
  }) async{
    try{
      Map<String, dynamic> data = await api.postVerifyOTPAPI(email: email, otp: otp);

      await handleSuccessWithReturn(data);
      return true;
    }catch(e){
      return await handleErrorWithReturn(e);
    }
  }
  
}

