import 'package:rxdart/subjects.dart';
import 'package:twwillustration/features/auth/data/login_data/login_rx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_rx.dart';
import 'package:twwillustration/features/auth/data/verify_otp/verify_otp_rx.dart';
import 'package:twwillustration/features/settings/data/logout_rx.dart';

PostSigninRX postSigninRX = PostSigninRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostSignupRX postSignupRXObj = PostSignupRX(
  empty: <String, dynamic>{}, 
  dataFetcher: BehaviorSubject<Map<String, dynamic>>()
  );

PostVerifyOtpRx postVerifyOtpRxObj = PostVerifyOtpRx(
  empty: <String, dynamic>{}, 
dataFetcher: BehaviorSubject<Map<String, dynamic>>()
);

PostLogoutRx postLogoutRxObj = PostLogoutRx(
  empty: <String, dynamic>{}, 
  dataFetcher: BehaviorSubject<Map<String, dynamic>>()
);

