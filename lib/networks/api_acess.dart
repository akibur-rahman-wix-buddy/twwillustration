import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_rx.dart';
import 'package:twwillustration/features/auth/data/verify_otp/verify_otp_rx.dart';

PostSignupRX postSignupRXObj = PostSignupRX(
  empty: <String, dynamic>{}, 
  dataFetcher: BehaviorSubject<Map<String, dynamic>>()
  );

PostVerifyOtpRx postVerifyOtpRxObj = PostVerifyOtpRx(
  empty: <String, dynamic>{}, 
dataFetcher: BehaviorSubject<Map<String, dynamic>>()
);