import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostCommentLikeApi {
  static final PostCommentLikeApi _singleton = PostCommentLikeApi._internal();
  PostCommentLikeApi._internal();

  static PostCommentLikeApi get instance => _singleton;

  Future<Map<String, dynamic>> postCommentLikeApi(int commentId) async {
    try {
      Response response = await postHttp(Endpoints.postCommentLikeURL(commentId));

      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
