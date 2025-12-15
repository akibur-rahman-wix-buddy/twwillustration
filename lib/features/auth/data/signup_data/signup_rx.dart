import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/auth/data/signup_data/signup_api.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class PostSignupRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostSignupAPI.instance;

  PostSignupRX({required super.empty, required super.dataFetcher});

  
  ValueStream get getFiledData => dataFetcher.stream;

  Future<bool> postSignupRX(
      {required dynamic firstName,
      required dynamic lastName,
      required dynamic email,
      required dynamic password}) async {
    try {
      Map<String, dynamic> data =
          await api.postSignupAPI(firstName: firstName, lastName: lastName, email: email, password: password);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

}
