import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_rx.dart';

PostSignupRX postSignupRXObj = PostSignupRX(
  empty: <String, dynamic>{}, 
  dataFetcher: BehaviorSubject<Map<String, dynamic>>()
  );