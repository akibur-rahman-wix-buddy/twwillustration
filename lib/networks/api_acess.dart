import 'package:rxdart/subjects.dart';
import 'package:twwillustration/features/auth/data/login_data/login_rx.dart';

PostSigninRX postSigninRX = PostSigninRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// PostSigninRX postSigninRX2 = PostSigninRX(
//   empty: <String, dynamic>{},
//   dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
// );
